#! /usr/bin/perl -w

# Script der laver en kmd-ca request.

# Følgende oplysninger kræves fra brugeren:
# Æ Ø Å eller ae oe aa i certifikatet?
# givenName
# surname
# email
# keyusage
# om den private nøgle skal enkrypteres
# eventuelt password for denne nøgle

# NB: Dette script er ikke tænkt som et "rigtigt" program, men som en
# illustration af hvordan en forespørgsel kan opbygges og laves.

################################################################################
# Check at brugeren ikke gav nogen argumenter
$arg = shift(@ARGV);

if (defined $arg && $arg ne "") {
    print STDERR "Brug: $0\n\tInteraktivt certifikat forespørgelses skaber program for KMD-CA\n";
    exit 1;
}

################################################################################
# Check at man kan køre openssl

$openssl = `which openssl`;
if ("" eq $openssl) {
    printf STDERR "Fejl: Du skal have installeret openssl programmet\n";
    printf STDERR "og det skal være tilgængeligt i din PATH (udførbart)\n";
    printf STDERR "Dette program kan fås fra http://www.openssl.org/\n";
    printf STDERR "De fleste distributioner inkluderer dog dette program\n";
    exit 1;
}

################################################################################
# Vi bruger ReadLine til at læse ting ind med - for at give en rimelig
# indlæsningsgrænseflade

use Term::ReadLine;
$term = new Term::ReadLine 'Certifikat';
$prompt = "> ";

################################################################################
# Lidt info til brugeren

printf "Dettte program vil lave en forespørgsel til KMD-CA for dig.\n";
printf "Du skal indtaste en række oplysninger\n\n";

################################################################################
# Læs de nødvendige værdier
do {
    
    $prompt = "Indtast dit fornavn : ";
    $givenName= $term->readline($prompt);

    $prompt = "Indtast dit efternavn : ";
    $surname = $term->readline($prompt);

    $prompt = "Indtast din emailadresse : ";
    $emailAddress = $term->readline($prompt);

    printf "Certifikatet kan bruges til enkryptering, signering eller begge dele\n";
    printf "Hvad skal det bruges til? [E]nkryptering, [S]ignering eller [B]egge?\n";
    $prompt = "Angiv hvad nøglen skal bruges til [e/s/B] : ";
    $keyUsage = $term->readline($prompt);
    
    if ("e" eq $keyUsage || "E" eq keyUsage) {
	$keyUsage = "Data Enchiperment";
    } else { 
	if ("s" eq $keyUsage || "S" eq $keyUsage) {
	    $keyUsage = "Digital Signature";
	} else {
	    $keyUsage = "Digital Signature, Data Enchiperment";
	}
    }

    printf "Nogle Certifikat udstedere understøtter ikke ÆØÅ (såsom KMD) og skal\n";
    printf "du bruge certifikatet med en sådan udsteder skal du svare J her, så\n";
    printf "konverterer jeg Æ, Ø, Å, til henholdsvis Ae, Oe, Aa.\n";
    $prompt = "Ønsker du at få konverteret ÆØÅ? [J/N] : ";
    $convert = $term->readline($prompt);

    #Konverter æøå og ÆØÅ hvis der blev valgt J ovenfor.
    if ($convert eq "J")  # do ÆØÅ conversions
    {
       foreach ($givenName,$surname,$emailAddress)
       {
	  printf "Converting ÆØÅ...\n";
          $_ =~ s/Æ/Ae/g;  # 
          $_ =~ s/Ø/Oe/g;  # 
          $_ =~ s/Å/Aa/g;  # 
          $_ =~ s/æ/ae/g;  # 
          $_ =~ s/ø/oe/g;  # 
          $_ =~ s/å/aa/g;  # 
       }
    }

    printf "Det anbefales at man beskytter sin private nøgle med en adgangskode\n";
    printf "Indtast en sådan - bemærk at den vil blive skrevet til skærmen\n";
    $prompt = "Angiv adgangskode : ";
    $output_password = $term->readline($prompt);
    
################################################################################
# Bekræft 
    
    printf "\nHer er de informationer du indtastede.\n\n";
    printf "NB. Bemærk at hvis du svarede J til Konverter ÆØÅ, vil alle ÆØÅ og\n";
    printf "    æøå være repræsenteret som Ae,Oe,Aa og ae, oe, aa nedenfor.\n\n";
    
    printf "Fornavn       : $givenName\n";
    printf "Efternavn     : $surname\n";
    printf "Email         : $emailAddress\n";
    printf "Nøglebrug     : $keyUsage\n";
    printf "Konverter ÆØÅ : $convert\n";
    printf "Adgangskode   : $output_password\n\n";
    
    $prompt = "Er informationerne korrekte? [J/n] : ";
    $OK = "J";
    $OK = $term->readline($prompt);
    
    if ("j" eq $OK || "" eq $OK) {
	$OK = "J";
    }
} while ($OK ne "J");

################################################################################
# Informationerne er OK - lav forespørgselsfilen

# Vi skal bruge en midlertidig fil, som skal være læsebeskyttet for andre
# Jeg ved ikke rigtigt hvordan man laver det smart i Perl.
$filename = "request.config.$$";
open (CONFIG, ">$filename") ||
    die "Kunne ikke åbne filen $filename - krævet for at forsætte\n";
chmod 0600, $filename ||
    die "Kunne ikke sætte rettigheder på $filename - krævet for at forsætte\n";

# Opbyg et par oplysninger
$fileprefix = $givenName."_".$surname;
$fileprefix =~ s/\s/\_/g;
$keyfile = $fileprefix."_Nøgle.pem";
$reqfile = $fileprefix."_Anmod.req";

$CN = "$givenName $surname // PID:xxxxxxxxx";


# Skriv oplysninger til fil 
print CONFIG 
"[ req ]
prompt                 = no
default_bits           = 1024

default_keyfile        = $keyfile
output_password        = $output_password

distinguished_name     = req_distinguished_name

[ req_distinguished_name ]
C                      = DK
O                      = Ingen organisatorisk tilknytning
CN                     = $CN
emailAddress           = $emailAddress
givenName              = $givenName
surname                = $surname
keyUsage               = $keyUsage
serialNumber           = 9208-2001-1-xxxxxxxxx
";
close (CONFIG) || 
    die "Kunne ikke lukke $filename - krævet for at forsætte\n";

################################################################################
# OK, nu er vi klar til at køre openssl. 
print "Information: Starter openssl (god ting)\n";
$status = 
system("openssl req -newkey rsa:1024 -config $filename -out $reqfile -outform DER");

# Slet config filen
$del = unlink ($filename);
if (1 != $del) {
    print STDERR "Advarsel: Det var ikke muligt at slette $filename\n";
} else {
    print "Information: Den midlertidige fil er blevet slettet (god ting)\n";
}

if (0 != $status) {
    print STDERR "Fejl: Der var en fejl under udførelsen af openssl kommandoen\n";
    print STDERR "En anmodningsfil er _ikke_ blevet lavet\n";
    exit 1;
}

print "\nSucces!\n";
print "I filen $reqfile ligger den anmodningsfil der skal sendes til KMD-CA\n";
print "I filen $keyfile ligger din private nøgle, som du skal passe godt på, og\n";
print "ikke lade andre få adgang til.\n";
