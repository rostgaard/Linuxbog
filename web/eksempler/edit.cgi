#!/usr/bin/perl

#Filnavn: echo.cgi

sub URLdekrypt
#Udfører url dekryption på en streng.
{
    my ($input)=(@_);

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

   if($contentLength)
    {
       if ($contentLength<$maxSize)
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

if ($ENV{'REQUEST_METHOD'} eq "POST") 
   {
      %data= URLdekrypt(HentPostData());                      #Post data
   }
  else
   {
      %data= URLdekrypt($ENV{'QUERY_STRING'});                #Get Data
   }

#Indtastningsdata er nu indlæst i %data

#Udskrivning af data
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
