#! /usr/bin/perl -w

# Script der laver en kmd-ca certifikat forespørgsel.

# Følgende oplysninger kræves fra brugeren:
# Æ Ø Å eller ae oe aa i certifikatet?
# givenName
# surname
# email
# keyusage
# om den private nøgle skal enkrypteres
# eventuelt password for denne nøgle

# NB: Dette script er ikke tænkt som et "rigtigt" slutbrugerprogram, men som en
# illustration af hvordan en forespørgsel kan opbygges og laves. Så vidt vides
# indeholder programmet ingen fejl og har den fulde funktionalitet til at lave
# en certifikat forespørgesel til brug for KMD-CA.

# Dette script frigives valgfrit under "Åben dokumentlicens" (ÅDL) eller 
# Gnu Public Licensen (GPL )v. 2.

# Oprindeligt lavet af Mads Bondo Dydensborg (madsdyd@challenge.dk)
# Tilføjelser af Klavs Klavsen og Christian Boesgaard
# Copyright 2002 Mads Bondo Dydensborg.

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
    print STDERR "Fejl: Du skal have installeret openssl programmet\n";
    print STDERR "og det skal være tilgængeligt i din PATH (udførbart)\n";
    print STDERR "Dette program kan fås fra http://www.openssl.org/\n";
    print STDERR "De fleste distributioner inkluderer dog dette program\n";
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

print "Dettte program vil lave en certifikat forespørgsel til KMD-CA for dig.\n\n";
print "Du skal indtaste en række oplysninger\n";
print "Efter indtastning af hver oplysning skal du trykke på enter/return\n";
print "For oplysninger hvor der gives flere valg, kan du som regel trykke enter for den\n";
print "mest almindelige værdi. Denne vil være illusteret med et stort bogstav.\n\n";

################################################################################
# Læs de nødvendige værdier
do {
    
    $prompt = "Indtast dit fornavn(e) : ";
    $givenName= $term->readline($prompt);

    $prompt = "Indtast dit efternavn : ";
    $surname = $term->readline($prompt);

    $prompt = "Indtast din emailadresse : ";
    $emailAddress = $term->readline($prompt);

    print "\nCertifikatet kan bruges til enkryptering, signering eller begge dele\n";
    print "Hvad skal det bruges til? [E]nkryptering, [S]ignering eller [B]egge?\n";
    $prompt = "Angiv hvad certifikatet skal bruges til [e/s/B] : ";
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

    print "\nNogle Certifikat udstedere understøtter ikke ÆØÅ (såsom KMD) og skal\n";
    print "du bruge certifikatet med en sådan udsteder skal du svare J her, så\n";
    print "konverteres Æ, Ø, Å, til henholdsvis Ae, Oe, Aa.\n";
    $prompt = "Ønsker du at få konverteret ÆØÅ? [J/n] : ";
    $convert = $term->readline($prompt);

    #Konverter æøå og ÆØÅ hvis der blev valgt J ovenfor.
    if ($convert eq "J" || "" eq $convert)  # do ÆØÅ conversions
    {
       foreach ($givenName,$surname,$emailAddress)
       {
	  #printf "Konverterer ÆØÅ...\n";
          $_ =~ s/Æ/Ae/g;  # 
          $_ =~ s/Ø/Oe/g;  # 
          $_ =~ s/Å/Aa/g;  # 
          $_ =~ s/æ/ae/g;  # 
          $_ =~ s/ø/oe/g;  # 
          $_ =~ s/å/aa/g;  # 
       }
    }

    printf "\nDet anbefales at man beskytter sin private nøgle med en adgangskode\n";
    printf "Indtast en sådan - bemærk at den vil blive skrevet til skærmen!\n";
    $prompt = "Angiv adgangskode : ";
    $output_password = $term->readline($prompt);
    
################################################################################
# Bekræft 
    
    print "\nHer er de informationer du indtastede.\n\n";
    print "NB. Bemærk at hvis du svarede J til Konverter ÆØÅ, vil alle ÆØÅ og\n";
    print "    æøå være repræsenteret som Ae,Oe,Aa og ae, oe, aa nedenfor.\n\n";
    
    print "Fornavn       : $givenName\n";
    print "Efternavn     : $surname\n";
    print "Email         : $emailAddress\n";
    print "Nøglebrug     : $keyUsage\n";
    print "Konverter ÆØÅ : $convert\n";
    print "Adgangskode   : $output_password\n\n";
    
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
print "\nTo filer er blevet lavet:\n\n";

print "\"$reqfile\" er den anmodningsfil KMD-CA skal have\n";
print "\"$keyfile\" er din private nøgle\n";
print "\nNB: Du må ikke lade andre få adgang til din private nøgle!\n";
