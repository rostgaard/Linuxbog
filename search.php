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

   list($width,$height) = getimagesize("front.png");
?>

<img src="front.png" alt="Friheden til at skrive bøger"
 align="right" width="<? echo $width ?>" height="<? echo $height ?>">
<h1>SSLUG - Friheden til at søge i sgml-filer</h1>

<form action="<?php echo $PHP_SELF ?>" method="get">
Søg efter:
<input type="text" name="q" value="<?php echo $q ?>" size="40">
<input type="submit" name="s" value="Submit">
<br>
<font size="-1">Der søges med <a href="friheden/bog/joker-redir-pipe.html#REGEXP">regulære udtryk</a> - case insentive</font>
</form>

<?php

function htmllink( $sgmlfil ) {
  //$link = preg_replace("|(\w+)/(\w+)\.sgml$|","\\1/bog/\\2.html", $sgmlfil);
  $link = $sgmlfil;
  $link = "<a href=\"$link\">$link</a>";
  return $link;
}

function searchdir( $dir, $q ) {
  $count = 0;
  $d = dir($dir);
  while ($fil = $d->read()) {
    if (preg_match("|^[a-z0-9]+\.sgml$|", $fil)) {
      $line = 0;
      $fd = fopen("$dir/$fil", "r");
      while (!feof($fd)) {
        $str = fgets($fd, 1024);
        $line++;
        if (preg_match("|$q|i", $str)) {
          if (!$count) echo "<p>\n";
          $count++;
          echo "<b>vi ".htmllink("$dir/$fil")." +$line</b><br>&nbsp;";
          echo "<i>".htmlentities($str)."</i><br>\n";
          flush();
        }
      }
      fclose($fd);
    }
  }
  $d->close();
  if ($count) {
    echo "<font size=\"-1\">Fundet <b>$count</b> tilfælde i <b>$dir</b></font>\n";
    echo "</p>\n";
  }
  return $count;
}

/*
 Man er doven. Vi gider kun at søge i de filer der
 ligger i de sub-dir der i dette sub-dir.
*/

if ($q) {
  flush();
  $d = dir(".");
  while ($dir = $d->read()) {
    if (is_dir($dir) && preg_match("|^[a-z0-9]+$|", $dir)) {
      //echo "<b>$dir</b><br>";
      $cnt = searchdir($dir, $q);
      //exit;
    }
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
