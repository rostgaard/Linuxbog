#!/usr/bin/perl

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

   if($ContentLength)
    {
       if ($ContentLength<$maxSize)
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


#udskriv data
print "Content-Type: text/plain\r\n\r\n";
print "Jeg modtog følgende data:\n";

my %data=URLdekrypt(HentPostData());

foreach (sort keys %data)
    {
       print "   $_ = \"$data{$_}\"\n";
    }
