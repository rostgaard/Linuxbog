#!/usr/bin/perl
#version Pi-3+0.42

$/=undef;

#Read content from STDIN or file

my $content;
my %tags;

if ($#ARGV == -1)
  {  # noarguments
     $content=<STDIN>;
  }
 else
  {
    if ($ARGV[0] =~ /--help/i)
      {
print <<EOF;
html til smgl konverter.
Syntax:
  htmltodoc.pl [indfil.html] [-o] [udfil.smgl]

STDIN og STDOUT bruges som default input/output hvis
ikke specificeret.
EOF
        exit(1);
      }

     open IN, $ARGV[0] or die "Error $!\n";
     $content=<IN>;
     close IN;
     print "$ARGV[0] -> ";
  }
  
#remove whitespace in tags.
$content =~ s/<\s*(.*?)\s*>/HandleTag($1)/ges;

#grab body of html page.
#$content =~ s/.*?<body>(.*?)<\/body>.*/$1/si;
$content =~ s/^.*?<body>//si;
$content =~ s/<\/body>.*?$//si;

#paragraphs
$content =~ s/<p>/<para>/g;
$content =~ s/<\/p>/<\/para>/g;

#Convert <pre> to <screen>   (Do this before <code> and <strong>!)
#takes care of <code> to <prompt> and <strong> to <userinput>
$content =~ s/<pre>(.*?)<\/pre>/HandlePre($1)/geis;

#Convert <code> to <command>
$content =~ s/\s*<code>\s*(.*?)\s*<\/code>\s*/ <command>$1<\/command> /gis;

#html <strong> to <filename>
$content =~ s/\s*<strong>\s*(.*?)\s*<\/strong>\s*/ <filename>$1<\/filename> /gis;

#html <i> to <emphasis>
$content =~ s/\s*<i>\s*(.*?)\s*<\/i>\s*/ <emphasis>$1<\/emphasis> /gis;

#html <em> to <emphasis>
$content =~ s/\s*<em>\s*(.*?)\s*<\/em>\s*/ <emphasis>$1<\/emphasis> /gis;

#Tags that require a handler: -------------------------------

#<ul>..</ul>
$content =~ s/<ul>(.*?)<\/ul>/HandleUl($1)/geis;

#<a ..>..</a>
# #name is converted to xref linkend
#  URL is converted to ulink
$content =~ s/<a\s+([^>]*)>(.*?)<\/a>/HandleA($1,$2)/geis;

#<img src=".." alt=".."> is converted to <figure>
$content =~ s/<\s*img\s*([^>]*)>/HandleImg($1)/geis;

#<table> ..</table> require some heavy modifications.
$content =~ s/<table([^>]*)>(.*?)<\/table>/HandleTable($1,$2)/geis;


#The following lines handles any balanced mixture of <h1>..<h4>
#assuming that no tags are embedded within eachother.
#<h1>..</h1>.. is converted into <chapter id="..">..</chapter>
#<h2>..</h2>.. is converted into <sect2 id="..">..</sect2>
#<h3>..</h3>.. is converted into <sect3 id="..">..</sect3>
#<h4>..</h4>.. is converted into <sect4 id="..">..</sect4>

$content =~ s/<h5(.*?)>(.*?)<\/h5>(.*?)(?=(<h5>|<h4>|<h3>|<h2>|<h1>|$))/HandleHead("sect5",$1,$2,$3)/geis;
$content =~ s/<h4(.*?)>(.*?)<\/h4>(.*?)(?=(<h4>|<h3>|<h2>|<h1>|$))/HandleHead("sect4",$1,$2,$3)/geis;
$content =~ s/<h3(.*?)>(.*?)<\/h3>(.*?)(?=(<h3>|<h2>|<h1>|$))/HandleHead("sect3",$1,$2,$3)/geis;
$content =~ s/<h2(.*?)>(.*?)<\/h2>(.*?)(?=(<h2>|<h1>|$))/HandleHead("sect2",$1,$2,$3)/geis;
$content =~ s/<h1(.*?)>(.*?)<\/h1>(.*?)((?=<h1>)|$)/HandleHead("chapter",$1,$2,$3)/geis;

#beautyfy kode. ------------------------------------------

#delete empty paragraphs.
$content =~ s/<para><\/para>//gi;

#fix spaces:
$content =~ s/\s*<para>/\n\n<para>/gis;
$content =~ s/\s*<\/para>\s*/<\/para>\n\n/gis;
$content =~ s/<screen>\s*/<screen>\n/gis;
$content =~ s/\s*<\/screen>/\n<\/screen>\n/gis;
$content =~ s/\s*<\/sect(.)>/\n<\/sect$1>/gis;

#print result to STDOUT or file.

foreach (sort keys %tags)
   {
     print $_ , " = " , $tags{$_},"\n";
   }

if ($#ARGV<1)
   {
      print $content;
   }
 elsif ($#ARGV == 1)  #infile outfile
   {
     my $outfile=$ARGV[1];
     open OUT, ">".$outfile or die "Error $!\n";
     print OUT $content;
     close OUT;        
     print $outfile,"\n";
   }
 else
   { 
     my $arg;
     foreach (@ARGV) {$arg.=$_." ";}
     $arg =~ /-o\s*([\w\.]*)/i; 
     $outfile=$1;

     open OUT, ">".$outfile or die "Error $!\n";
     print OUT $content;
     close OUT;        
     print $arg,"\n";
   }

# handlers : ---------------------------------------------------------------


sub HandleTag
#handles any <..> and </..> tag.
#Used for lowercasing tags (my preference)
{
  my ($tag)=(@_);
  $tag=lc $tag;

  if ($tag =~ /^\//)
     {
#remove whitespace between / and tag
        $tag =~ s/\/\s*(.*)/\/$1/i;
     }
   
  return "<$tag>";
}

sub HandleHead
#handles H1-H5
#<h? [title=".."]>..[<a name="..">]</h?>
{
  my ($tag,$inhead,$title,$content)=(@_);
  my $id;

#remove whitespace
  $title =~ s/^\s*//s;
  $title =~ s/\s*$//s;


#<h1 title="id">..</h1>
  if ($inhead =~ /title/i)
      {
         $inhead =~ /title\s*=\s*"?\s*([^"\s]*)/i;
         $id=$1;
      }

#override title by <a name="..">
  if ($title =~ /<a\s*name/i)
      {
         $title =~ /<a\s*name\s*=\s*"?\s*([^"\s]*)/i;
         $id=$1;
      }

#remove all tags from title
  $title =~ s/<\/?[^>]*>//g;

  my $ret;
  if ($id) 
   {
     $ret="\n<$tag id=\"$id\">\n";
   }
  else
   {
     $ret="\n<$tag>\n";
   }

  $content =~ s/^\s*//s;
  $content =~ s/\s*$//s;

  $ret.="  <title>$title<\/title>\n";
  $ret.=$content."\n";
  $ret.="</$tag>    <!-- $id  $title -->\n";
}


sub HandlePre
#<pre>..</pre>
{
  my ($prebody)=(@_);

  $prebody =~ s/<code>/<prompt>/gi;
  $prebody =~ s/<\/code>/<\/prompt>/gi;
  $prebody =~ s/<strong>/<userinput>/gi;
  $prebody =~ s/<\/strong>/<\/userinput>/gi;

  return "<screen>$prebody</screen>";
}

sub HandleUl
#<ul> -> <itemizedlist>
#handles HTML 3.2 <li>..<li>..<li> as well as HTML4.0 <li>..</li><li>..</li>
#paragraph tags are inserted after <li> and before </li>
{
  my ($ulbody)=(@_);
  my @item;

#whitespace zap:
  $ulbody =~ s/^\s*//s;
  $ulbody =~ s/\s*$//s;

#remove paragraphs they will be inserted later.
  $ulbody =~ s/<para>//s;
  $ulbody =~ s/<\/para>//s;
  $ulbody =~ s/<p>//s;
  $ulbody =~ s/<\/p>//s;

  while ($ulbody =~ /(?<=<li>)\s*(.*?)\s*(?=(<li>|<\/li>|$))/cgis)
    { 
      push (@item, $1);
    }

   my $ret;

   $ret="<itemizedlist mark=\"bullet\">";
   foreach (@item)
     {
       $ret.="\n  <listitem>\n";
       $ret.="     <para>$_</para>\n";
       $ret.="  </listitem>\n";
     }
   $ret.="</itemizedlist>\n";

  return $ret;
}

sub HandleA
#Generates Link.
#discards any <a onHandler> etc. Handles missing "'s gracefully.

#  <a href="#name">   -> xref linkend
#  <a href="http:.."> -> ulink
{
  my ($abody,$linktext)=(@_);

#grab URL. 
  $abody =~ /href\s*=\s*"?([^"\s]*)/is;
  my $url=$1;

#local ref.
  if ($url =~ /^#(.*)/)
      {
#..</a> tail deleted as target is automatically inserted.

        return "<xref linkend=\"$1\">";
      }
   else
      {
        return "<ulink url=\"$url\">$linktext<\/ulink>";
      }
}

sub HandleImg
#converts <img> to <figure>..
#what about scale="60" ?

#<img src=".." [title=".."] [alt=".."] [longdesc=".."]>
{
  my ($con)=@_;

#get src=".."
  my $url;
  if ($con =~ /src\s*=\s*"?([^"\s]*)/is) {$url=$1;}
    else
     {
        print STDERR "Ingen src=.. fundet i $con!";
     }

#get alt=".."
  my $alt;
  if ($con =~ /alt\s*=\s*"\s*(.*?)\s*"/is) {$alt=$1;}

  my $longdesc;
  if ($con =~ /longdesc\s*=\s*"\s*(.*?)\s*"/is) { $longdesc=$1;}

  my $id;
  if ($con =~ /title\s*=\s*"\s*(.*?)\s*"/is) {$id=$1;}

  if ($url =~ /http/i)
        {
          print STDERR "http fundet i <img $con> det bør kun være et filnavn!\n";
        }

  my $ret;
  
  if (not $id) {$id = $alt;}

  if ($id)
    {
      $ret.="<figure id=\"$id\" float=\"1\">\n";
    }
  else
    {
      $ret.="<figure float=\"1\">\n";
    }

  if ($longdesc)
    {
      $ret.="<title>$longdesc</title>\n";
    }
   elsif ($alt)
    {
      $ret.="<title>$alt</title>\n";
    }

   $ret.="<graphic fileref=\"$url\" scale=\"60\"></graphic>\n";
   $ret.="</figure>\n";
}

sub HandleTable
#<table [summary=".."]>
#[<caption>..</caption>]
#[<thead>..</thead>]
#[<tbody>]..[</tbody>]</table>
{
  my ($intable,$con)=@_;

#Get summary -> id
  my $summary;
  if ($intable =~ /summary\s*=\s*"?([^"]*)/is)
     {
        $summary=" id=\"$1\"";
      }

#grab caption if it exists
  $con =~ s/<caption>(.*?)<\/caption>//is;
  my $title=$1;

#basic subst
  $con =~ s/\s*<td>\s*/<entry>/gis;
  $con =~ s/\s*<\/td>\s*/<\/entry>/gis;
  $con =~ s/\s*<tr>\s*/<row>/gi;
  $con =~ s/\s*<\/tr>\s*/<\/row>/gi;

#beautyfy:
  $con =~ s/<row>/\n<row>\n/gi;
  $con =~ s/<\/row>/<\/row>\n/gi;
  $con =~ s/<entry>/  <entry>/gi;
  $con =~ s/<\/entry>/<\/entry>\n/gi;

  my $thead;
  my $tbody;

#Grab thead part if exists
  if ($con =~ s/(<thead>.*?<\/thead>)//is)
     {
         $thead=$1;
     }

  if ($con =~ /(<tbody>.*?<\/tbody>)/is)
       {
           $tbody=$1;
       }  
   else
       {
#<table><tr>..</tr>..</table>
#Assumes list of <row>..</row>'s
           $con =~ s/^\s*//s; 
           $con =~ s/\s*$//s; 
  
           $tbody="<tbody>\n$con\n</tbody>";  
       }

#  $thead =~ s/<entry>(.*?)</entry>


#count columns.
  $tbody =~ /<row>(.*?)<\/row>/is;
  $con = $1;

#count no. of <entry> in first <row>..</row>
  my $count=0; 
  while ($con =~ /<entry>/cgi) {$count++;}

  my $ret;

  $ret="<table$summary>\n";

  if ($title) 
   {
     $ret.="<title>$title</title>\n";
   }
  $ret.="<tgroup cols=\"$count\" align=\"char\">\n";

  if ($thead)
   {
     $ret.=$thead."\n\n";
   }

   $ret.=$tbody."\n\n";
   $ret.="</tgroup>\n</table>\n\n";
  
   return $ret;
}
