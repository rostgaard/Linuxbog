<?php
   // $Id$
   // Første version af Hans Schou.

   /* top.phtml sets 
      <!--DOCTYPE ....
      .....
      ... [topmenu] ...
   */
   $htmltitle_en="SSLUG - Liberty of searching in sgml files";
   $htmltitle_da="SSLUG - Friheden til at søge i bøger";
   $htmltitle_sv="SSLUG - Friheden til at söke i böcker";
   $bodyarg=" background=\"/grafix/linux-back-1.gif\" ";
   $maintain_name = "Hans Schou";       // Skriv dit navn her
   $maintain_email = "chlor@sslug.dk";  // Skriv din email adresse her
   @include($DOCUMENT_ROOT."/includes/top.phtml");

   list($width,$height) = @getimagesize("front.png");

   # \\ skal laves om til \
   if (isset($q))
     $q = preg_replace("|\\\\\\\|", "\\", $q);

?>

<img src="front.png" alt="Friheden til at skrive bøger"
 align="right" width="<? echo $width ?>" height="<? echo $height ?>">
<h1>SSLUG - Friheden til at søge i sgml/html-filer</h1>

<form action="<?php echo $PHP_SELF ?>" method="get">
Søg efter:
<input type="text" name="q" value="<?php echo $q ?>" size="40">
<input type="submit" name="s" value="Submit">
<br>
<font size="-1">Der søges med <a href="http://www.sslug.dk/linuxbog/unix/bog/regexp.html">regulære udtryk</a> - case insentive</font>
</form>

<?php

function htmllink( $sgmlfil ) {
  return "<a href=\"$sgmlfil\">$sgmlfil</a>";
}

function searchinfile( $file, $q ) {
  $count = 0;
  $line = 0;
  $fd = fopen($file, "r");
  while (!feof($fd)) {
    $str = fgets($fd, 1024);
    $line++;
    if (preg_match("|$q|i", $str)) {
      if (!$count) echo "<p>\n";
      $count++;
      echo "<b>vi ".htmllink($file)." +$line</b>\n";
      echo "<br>&nbsp;\n";
      echo "<i>".htmlentities($str)."</i><br>\n";
      flush();
    }
  }
  fclose($fd);
  if ($count) echo "</p>\n\n";
  return $count;
}

function searchdir( $dir, $ext, $q ) {
  $count = 0;
  $d = dir($dir);
  while ($fil = $d->read())
    if (is_file($dir."/".$fil) && preg_match("|^[a-z0-9-_]+.+\.${ext}$|", $fil))
      $count += searchinfile("$dir/$fil", $q);
  $d->close();
  return $count;
}

/*
 Man er doven. Vi gider kun søge i de filer der
 ligger i de sub-dir der er i dette sub-dir.
*/

if ($q) {
  flush();
  $d = dir(".");
  while ($dir = $d->read())
    if (@is_dir($dir)) {
      # Prøv og find nogle SGML filer
      if (preg_match("|^[a-z0-9]+$|", $dir))
        $count += searchdir($dir, "sgml", $q);
      # prøv med HTML
      if (@is_dir("$dir/bog"))
        $count += searchdir("$dir/bog", "html", $q);
    }
  $d->close();
}

?>

<p>
<!-- Text slut -->
<!-- Husk din email-adresse: -->
<?php
  @include($DOCUMENT_ROOT."/includes/bottom.phtml");
?>
