#!/usr/bin/perl

sub URLdekrypt
#Udfører url dekryption på en streng.
{
    my ($input)=(@_);
print $input;

    my ($variabel,$indtastning);
    my %data;

#Klip input strengen ved all '&' karaktere

    my @query=split /&/, $input;

#loop gennem tabellen af "variabel=indtastning" strenge

    foreach (@query)
      {

#Klip ved '='

        ($variabel,$indtastning)=split /=/, $_;

#fix '+' før %xy!

        $variabel    =~ tr/+/ /;
        $indtastning =~ tr/+/ /;

#null karaktere uønskede!
        $variabel    =~ s/%00//g;
        $indtastning =~ s/%00//g;

#substituter %xy med den tilsvarende karakter..

        $variabel    =~ s/%([0-9A-Fa-f]{2})/pack("c",hex($1))/ge;
        $indtastning =~ s/%([0-9A-Fa-f]{2})/pack("c",hex($1))/ge;

#Hvis flere felter har samme navn så konkateneres deres indhold
#separeret af en '|' karakter.

        if ($data{$variabel})
            { $data{$variabel}=$data{$variabel}."|".$indtastning; }
          else
            { $data{$variabel}=$indtastning; } 
      }

   return %data;
}


sub HentPostData
#Returnere en variabel med strengen på stdin
{
#antallet af bytes der venter på stdin
   my $ContentLength = $ENV{"CONTENT_LENGTH"};

   my $input="";

#max 10 kb input.
   my $maxSize=10240;

   if($ContentLength)
    {
       if ($ContentLength < $maxSize)
          {
            read(STDIN,$input,$ContentLength);
          }
        else
          {
            print "Content-Type: text/plain\r\n\r\n";
            print "Script input exceeds acceptible size limit!";
            die "Error! $ENV{'REMOTE_ADDR'} attempted to submit $contentLength bytes!\n"; 
          }
     }

   return $input;
}


my %data;

#debug kode ------------------------------------------------

#basefilenavn
my $filename="grab";

#0 for at modtage data fra webserveren og bearbejde dem.
#1 for at slå debugging til

my $isDebug = 1;    

#0 for at afspille data fra fil.
#1 for at gemme data

my $grabdata = 1;   

sub Fejl
#udskriver fejl til browser og error_log
{
  print "Content-Type: text/plain\r\n\r\n";
  print "Fejl! $!\n";
  die "Fejl! $!\n";
}

sub GemHash
#Gemmer en hash til en fil i et XML lignende format.
{
   my ($hashref,$filnavn)=@_;
   my $tag,$streng;

   open OUT, $filnavn or die Fejl;
   while (($tag,$streng)=each %$hashref)
      {
#For at dekryption skal være entydig må '<' og '>' escapes.
         $streng =~ s/&/&amp;/g;
         $streng =~ s/</&lt;/g;
         $streng =~ s/>/&gt;/g;

         print OUT "<$tag>$streng</$tag>\n";
      }
   close OUT;  
}

sub HentHash
#Henter en hash fra en fil.
{
   my ($hashref,$filnavn)=@_;
   my $content;

#backup af record separatoren.
   my $tmp=$/; 

#indlæs hele filen på en gang
   open IN, $filnavn or die Fejl;
   $/=undef;
   $content=<IN>;

#loop gennem alle <tag>data</tag>'s.
   while ($content =~ /<(.*?)>([^>]*)<\/\1>/gc) { tohash($hashref,$1,$2); }

   $/=$tmp;
}

sub tohash
#addere hash data efter at escaped karaktere er fixet
{
  my ($hashref,$key,$str)=(@_);

#Fix escaped karaktere.
  $str =~ s/&lt;/</g;
  $str =~ s/&gt;/>/g;
  $str =~ s/&amp;/&/g;

  $$hashref{$key}=$str;
}

if (not $isDebug or $isDebug and $grabdata)
   {
#hvis ikke i debug mode skal inddata fortolkes.
#hvis i debug mode og grabdata så skal inddata også fortolkes.

        if ($ENV{'REQUEST_METHOD'} eq "POST") 
          {
             %data= URLdekrypt(HentPostData());          #Post data
          }
         else
          {
             %data= URLdekrypt($ENV{'QUERY_STRING'});    #Get Data
          }
   }

if ($isDebug)
{
  if ($grabdata)
     {
#Gem environment variable og data hash.
        GemHash(\%ENV, ">".$filename.".env");
        GemHash(\%data,">".$filename.".var");

#udskriv og stop scriptet når data er gemt.
        print "Content-Type: text/plain\r\n\r\n";
        print "Data er opsamlet og gemt i \"$filename.*\".";
        print "Sæt \$grabdata=0 og kør scriptet i en debugger\n";
        die;
     }
  else
     {     
#Slet alle environment variable
        %ENV=();

#hent environment og data hash fra filer.
        HentHash(\%ENV,  $filename.".env");
        HentHash(\%data, $filename.".var");

#fortsæt cgi programmet.
     }
}


#Her behandles webformular data.
print "Content-Type: text/plain\r\n\r\n";
print "Variable Modtaget:\n\n";

#udskriv environment variable
print "Environment variable:\n";
foreach (sort keys %ENV)
    {
       print "   $_ = \"$ENV{$_}\"\n";
    }

#udskriv webformular data

if (%data)
{
  print "\nWebformular data:\n";

  foreach (sort keys %data)
    {
       print "   $_ = \"$data{$_}\"\n";
    }
}

#Hvis POST metoden bruges og der er argumenter så udskriv disse.

if ($ENV{'QUERY_STRING'} and $ENV{'REQUEST_METHOD'} eq "POST")
 {
   print "\nArgumenter:\n";

   foreach (split /&/, $ENV{'QUERY_STRING'})
       {
          print "   \"$_\"\n";
       }
}
