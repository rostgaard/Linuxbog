# ! /usr/bin/perl -w -p -i

## Claus Ekstroem <ce@biostat.ku.dk>
## Peter Makholm <peter@makholm.net>


my $convert = 0;

while (<>) {
  $convert = 1 if /<screen>/;
  $convert = 0 if /<\/screen>/;
  
  s/--/\&dash;\&dash;/g if ($convert ==1);
  s/>>/\&gt;\&gt;/g if ($convert ==1);
  print;
}
