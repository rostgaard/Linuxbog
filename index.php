<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
        "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<HTML>
<HEAD>
<!-- Husk titel. Skal begynde med "SSLUG - " -->
   <TITLE>SSLUG - Friheden til at vælge</TITLE>
<LINK REL="STYLESHEET" HREF="/style/sslug.css" TYPE="text/css">
</HEAD>
<BODY>
<?php
  include($DOCUMENT_ROOT."includes/top.phtml");
?>

<h1 align="center">SSLUG - Friheden til at vælge</h1>
<!--
$Id$
-->
<?php

function href($url,$desc) {
  return "<a href=\"$url\">$desc</a>";
}

// Returner filstørrelse i human readable format
function fsize_text( $filename ) {
  // ISO filstørrelser, ex: 5.5 MB
  $ISO = array("","K","M","G","T","P");
  $filesize = filesize($filename);
  if (! $filesize) {
      return "000 B";
  } else {
    $base = floor(floor(log10($filesize))/3);
    $num3 = $filesize/pow(1024,$base);
    return substr($num3,0,(strpos($num3,".")>2?3:4))." ".$ISO[$base]."B";
  }
}

  // friheden/linux-friheden.tgz
  // friheden/bog/index.html

  $books = array(
    // Bognavn, forkortet
    "friheden" => array(
      title => "Linux - Friheden til at vælge",
      comment => "En god begynderbog",
      audt => array(
        "Peter Toft" => "pto@sslug.dk",
        "Hans Schou" => "chlor@sslug.dk"
      )
    ),
    "admin" => array(
      title => "Linux - Friheden til systemadministration",
      comment => "Administrer din egen Linux-server",
      audt => array(
        "Peter Toft" => "pto@sslug.dk"
      )
    ),
    "program" => array(
      title => "Linux - Friheden til at programmere",
      comment => "Programmering på Linux",
      audt => array(
        "Peter Toft" => "pto@sslug.dk",
        "Hans Schou" => "chlor@sslug.dk"
      )
    ),
    "sikkerhed" => array(
      title => "Linux - Friheden til at have sin server i fred",
      comment => "Sikkerhed omkring din Linux-boks",
      audt => array(
        "Peter Toft" => "pto@sslug.dk",
        "Hans Schou" => "chlor@sslug.dk"
      )
    ),
    "web" => array(
      title => "Linux - Friheden til egen webserver",
      comment => "Web og datadaser",
      audt => array(
        "Peter Toft" => "pto@sslug.dk",
        "Hans Schou" => "chlor@sslug.dk"
      )
    )/*,
    "kerne" => array(
      title => "Linux - Friheden til kernen",
      comment => "Forstå Linux-kernen til bunds",
      audt => array(
        "Jacob Laursen" => "lau@sslug.dk",
        "Peter Toft" => "pto@sslug.dk"
      )
    )*/
  );

  // Bogpakker
  // <first><$books><last>
  $packs = array(
    // Eks: frihed/index.html
    "Online" => array(
      first => "bog",
      last => "/index.html",
      online => 1  // Hvis bognavn kun skal med een gange
    ),
    // Eks: linux-frihed.tgz
    "HTML" => array(
      first => "linux-",
      last => ".html.tgz"
    ),
    "HTML u/billeder" => array(
      first => "linux-",
      last => ".html-ub.tgz"
    ),
    "PostScript" => array(
      first => "linux-",
      last => ".ps.gz"
    ),
    // Eks: linux-frihed-pdf.gz
    "PDF" => array(
      first => "linux-",
      last => ".pdf.gz"
    ),
    "Tekst" => array(
      first => "linux-",
      last => ".txt.gz"
    ),
    "PalmPilot" => array(
      first => "linux-",
      last => ".palm.tgz"
    ),
    "SGML" => array(
      first => "linux-",
      last => ".sgml.tgz"
    )
  );

  $bgcolor = array("#F0F0F0","#E8E8E8");

?>
<h2>Vi har følgende bøger</h2>
<a href="#matrix">Matrix med alle bøger</a>
<p>
Filtyper: 
<?php

  reset($packs);
  while (list($type,$attr) = each($packs)) {
    echo "<a href=\"#".rawurlencode($type)."\">$type</a>\n";
  }

?>
<p>
<ul>
<?php

  reset($books);
  while (list($short,$desc) = each($books)) {
    echo "<li><b>$short:</b> ";
    echo href("#$short","<b>$desc->title</b>");
    echo "<br> $desc->comment";
    echo "</li>\n";
  }
?>
</ul>
<?php

function form_filename( $bookname, $format ) {
  if ($format[online])
    return "$bookname/$format[first]$format[last]";
  else {
		$fp = fopen("$bookname/version.sgml", "r");
		$version = chop(fgets($fp, 80));
	// XXX	 linux-admin-1.0.ps.gz
		fclose($fp);
    return "$bookname/$format[first]$bookname-$version$format[last]";
	}
}

  reset($books);
  while (list($short,$desc) = each($books)) {
    echo "<hr><a name=\"$short\"></a><h3>$desc->title</h3>\n";
    echo "$desc->comment";
    echo "<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\">\n<tr>\n";
    echo "<th>Bøger</th>\n";
    echo "<th>Link</th>\n";
    echo "<th>Dato</th>\n";
    echo "<th>Bytes</th>\n";
    echo "</tr>\n";
    reset($packs);
    while (list($type,$attr) = each($packs)) {
      echo "<tr>\n";
      $filename = form_filename($short, $attr );
      echo "<td><b>$type</b></td>\n";
      if (file_exists($filename)) {
        echo "<td>".href($filename,"<b>$filename</b>")."</td>\n";
        $date = date("Y-m-d",filemtime($filename));
        $filesize = fsize_text($filename);
      } else {
        echo "<td>$filename</td>\n";
        $date = " - ";
        $filesize = "00 B";
      }
      echo "<td>$date</td>\n";
      if ($attr[online])
        echo "<td>&nbsp;</td>\n";
      else
        echo "<td>$filesize</td>\n";
      echo "</tr>\n";
    }
    echo "</table>\n";
  }

  reset($packs);
  while (list($type,$attr) = each($packs)) {
    echo "<hr><a name=\"".rawurlencode($type)."\"></a><h3>$type</h3>\n";
    echo "<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\">\n<tr>\n";
    echo "<th>Bøger</th>\n";
    echo "<th>Link</th>\n";
    echo "<th>Dato</th>\n";
    echo "<th>Bytes</th>\n";
    echo "</tr>\n";
    reset($books);
    while (list($short,$desc) = each($books)) {
      echo "<tr>\n";
      $filename = form_filename($short, $attr );
      echo "<td><b>$short</b></td>\n";
      if (file_exists($filename)) {
        echo "<td>".href($filename,"<b>$filename</b>")."</td>\n";
        $date = date("Y-m-d",filemtime($filename));
        $filesize = fsize_text($filename);
      } else {
        echo "<td>$filename</td>\n";
        $date = " - ";
        $filesize = "00 B";
      }
      echo "<td>$date</td>\n";
      if ($attr[online])
        echo "<td>&nbsp;</td>\n";
      else
        echo "<td>$filesize</td>\n";
      echo "</tr>\n";
    }
    echo "</table>\n";
  }

?>
<hr>
<p>
<a name="matrix"></a>
<table border="1" cellspacing="0" cellpadding="3">
<tr bgcolor="#F0F0FF"><th>Bøger/filtype</th>
<?php

  reset($packs);
  list($type) = current($packs);
  while (list($type) = each($packs)) {
    echo " <th>$type</th>\n";
  }
  echo "</tr>\n";
  
  $c = 0;
  reset($books);
  while (list($short,$desc) = each($books)) {
    echo "<tr bgcolor=\"".$bgcolor[++$c & 1]."\">\n <td valign=\"top\">";
    echo "<b>$desc[title]</b></td>\n";
    reset($packs);
    while (list($type,$attr) = each($packs)) {
      echo " <td valign=\"top\"><font size=\"-1\">";
      $filename = form_filename( $short, $attr );
      $filetext = "$short $type";
      if (!file_exists($filename)) {
        echo "$filetext";
        $date = " - ";
      } else {
        $filesize = fsize_text($filename);
        echo href($filename,$filetext);
        $date = date("Y-m-d",filemtime($filename));
        echo "<br>$date<br>$filesize";
      }
      echo "</font></td>\n";
    }
    echo "</tr>\n";
  }
?>
</table>

<!-- Text slut -->
<!-- Husk din email-adresse: -->
<?php
  include($DOCUMENT_ROOT."includes/top.phtml");
?>
<center><p>Denne side vedligeholdes af Hans Schou (&lt;<A HREF="mailto:chlor@sslug.dk">chlor@sslug.dk</a>&gt;)</p>
</center>
</BODY>
</HTML>
