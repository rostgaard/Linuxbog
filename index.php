<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
        "http://www.w3.org/TR/REC-html40/loose.dtd">
<!--
$Id$
-->
<html>
<HTML>
<HEAD>
<!-- Husk titel. Skal begynde med "SSLUG - " -->
   <TITLE>SSLUG - Friheden til at skrive b�ger</TITLE>
<LINK REL="STYLESHEET" HREF="/style/sslug.css" TYPE="text/css">
</HEAD>
<BODY>
<?php

  // Nogen vil gerne se kildeteksten, og det skal de da have lov til.
  // Men l�s hellere om PHP i "Linux - Friheden til at programmere".
  if ($show_source) {
    echo "<tt>";
    show_source(basename($PHP_SELF));
    echo "</tt></BODY></HTML>";
    exit;
  }

  include($DOCUMENT_ROOT."includes/top.phtml");

	list($width,$height) = getimagesize("front.png");
?>

<img src="front.png" alt="Friheden til at skrive b�ger"
 align="right" width="<? echo $width ?>" height="<? echo $height ?>">
<h1>SSLUG - Friheden til at skrive b�ger</h1>
</p>

<?php

// Funktion til at lave hyperlink
function href($url,$desc) {
  return "<a href=\"$url\">$desc</a>";
}

// Returner filst�rrelse i human readable format
function fsize_text( $filename ) {
  // ISO filst�rrelser, ex: 5.5 MB
  $ISO = array("","k","M","G","T","P");
  $filesize = filesize($filename);
  if (! $filesize) {
      return "000 B";  // file_exists() skulle v�re checket her
  } else {
    $base = floor(floor(log10($filesize))/3);
    $num3 = $filesize/pow(1024,$base);
    return substr($num3,0,(strpos($num3,".")>2?3:4))." ".$ISO[$base]."B";
  }
}

// Funktion til at formatere finavne.
// Online versionen skal kun have bookname een gang
function form_filename( $bookname, $format ) {
  if ($format[online])
    // Eks: admin/bog/index.html
    return "$bookname/$format[first]$format[last]";
  else {
    // Eks: admin/linux-admin-1.0.ps.gz
    $fp = fopen("$bookname/version.sgml", "r");
    $version = trim(fgets($fp, 80));
    fclose($fp);
    return "$bookname/$format[first]$bookname-$version$format[last]";
  }
}

  // B�ger
  $books = array(
    // Bognavn, forkortet
    "friheden" => array(
      title => "Linux - Friheden til at v�lge",
      comment => "En god begynderbog",
      auth => array(
        "Peter Toft" => "pto@sslug.dk",
        "Hans Schou" => "chlor@sslug.dk"
      )
    ),
    "admin" => array(
      title => "Linux - Friheden til systemadministration",
      comment => "Administrer din egen Linux-server",
      auth => array(
        "Peter Toft" => "pto@sslug.dk",
        "Hans Schou" => "chlor@sslug.dk"
      )
    ),
    "program" => array(
      title => "Linux - Friheden til at programmere",
      comment => "Programmering p� Linux",
      auth => array(
        "Peter Toft" => "pto@sslug.dk",
        "Hans Schou" => "chlor@sslug.dk"
      )
    ),
    "sikkerhed" => array(
      title => "Linux - Friheden til sikkerhed p� internettet",
      comment => "Sikkerhed omkring din Linux-boks",
      auth => array(
        "Peter Toft" => "pto@sslug.dk",
        "Hans Schou" => "chlor@sslug.dk"
      )
    ),
    "web" => array(
      title => "Linux - Friheden til egen webserver",
      comment => "Web og databaser",
      auth => array(
        "Peter Toft" => "pto@sslug.dk",
        "Hans Schou" => "chlor@sslug.dk"
      )
    )
  );

  // Bogpakker pakket p� forskellige m�der
  // <first><$books><last>
  $packs = array(
    // Eks: frihed/bog/index.html
    "Online" => array(
      first => "bog",
      last => "/index.html",
      online => 1  // Hvis bognavn kun skal med een gange
    ),
    // Eks: frihed/linux-frihed-4.0.tgz
    "HTML" => array(
      first => "linux-",
      last => ".html.tgz"
    ),
    "PNG" => array(
      first => "linux-",
      last => ".png.tgz"
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
    "PalmPilot" => array(
      first => "linux-",
      last => ".palm.tgz"
    ),
    "SGML" => array(
      first => "linux-",
      last => ".sgml.tgz"
    )
  );

  $bgcolor = array("#FFFFFF","#E8E8E8");

?>
<h2>Vi har f�lgende b�ger</h2>
<a href="#matrix">Samlet bogoversigt</a>
<p>
Filtyper: 
<?php

  // Kort liste over filtyper: "Online, HTML..."
  reset($packs);
  while (list($type) = each($packs)) {
    // Nogle filtyper har mellemrum i navnet, derfor bruges rawurlencode()
    echo "<a href=\"#".rawurlencode($type)."\">$type</a>\n";
  }

?>
<p>
<ul>
<?php

  // P�n bullet liste over alle bog-titler med kort beskrivelse
  reset($books);
  while (list($short,$desc) = each($books)) {
    echo "<li><b>$short:</b> ";
    echo href("#$short","<b>$desc->title</b>");
    echo "<br> $desc->comment";
    echo "</li>\n";
  }
?>
</ul>
<p>

Benyt vores "Et-klik-service" for at downloade og l�se b�gerne,
eller k�b en indbundet udgave hos f�lgende forretninger:
<ul>
<li><a href="http://www.printxpress.dk/linuxbog/">PrintXpress</a></li>
<li><a href="http://www.pn-tryk.dk/html/linux.html">PN-tryk</a></li>
<li><a href="http://www.sc-birkeroed.dk/htm-sider/Linux.htm">SC-Birker�d</a></li>
</ul>
B�gerne er udgivet under <a href="opl.shtml">OpenContent License</A>
hvilket g�r at SSLUG ikke er indvolveret i de trykte udgaver.
<p>

B�gerne kan ogs� f�s i
<a href="http://www.plomus.dk/diverse/index.html#Linuxbog2Word">Microsoft Word format</a>.
<p>

<FORM METHOD="GET" ACTION="http://www.netmind.com/cgi-bin/uncgi/url-mind">
Vil du modtage E-post om nye versioner af bogen?
<BR>Skriv din E-post adresse her
<BR><INPUT TYPE=TEXT SIZE=40 NAME="required-email">
<BR><INPUT TYPE=HIDDEN VALUE="http://www.sslug.dk/linuxbog" NAME="url">
<INPUT TYPE=SUBMIT VALUE="Indsend form"></FORM>
<p>

B�gerne redigeres af Peter Toft og Hans Schou
&lt;<a href="mailto:linuxbog@sslug.dk">linuxbog@sslug.dk</a>&gt;.
<br>
Indholdet af b�gerne diskuteres p�
&lt;<a href="mailto:sslug-bog@sslug.dk">sslug-bog@sslug.dk</a>&gt;.
<p>

<hr>
<a name="matrix"></a>
<h2>Samlet bogoversigt</h2>
<table border="1" cellspacing="0" cellpadding="3">
<tr bgcolor="#F0F0FF"><th>B�ger/filtype</th>
<?php

  // Stor tabel med alle b�ger og filtyper samlet.
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
    echo "<b>$desc[title]</b><font size=\"-1\"><br>$desc[comment]</font></td>\n";
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
        $date = date("Y-m-d",filemtime($filename));
        //echo "<br>$date<br>$filesize";
				$linktext = "$date<br>$filesize";
        echo href($filename,$linktext);
      }
      echo "</font></td>\n";
    }
    echo "</tr>\n";
  }
?>
</table>
<p>

<?php

  echo "<hr><h2>B�ger</h2>\n";

  // Liste over alle b�ger. Alle b�ger har hver sin tabel med forskellig filtyper
  reset($books);
  while (list($short,$desc) = each($books)) {
    echo "<a name=\"$short\"></a><h3>$desc->title</h3>\n";
    echo "$desc->comment";
    echo "<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\" bgcolor=\"#F8F8E0\">\n<tr>\n";
    echo "<th>B�ger</th>\n";
    echo "<th>Link</th>\n";
    echo "<th>Dato</th>\n";
    echo "<th>Bytes</th>\n";
    echo "</tr>\n";
    // Her kommer listen over filtyper
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
        $filesize = " - ";
      }
      echo "<td align=\"center\">$date</td>\n";
      if ($attr[online])
        echo "<td>&nbsp;</td>\n";
      else
        echo "<td align=\"right\">$filesize</td>\n";
      echo "</tr>\n";
    }
    echo "</table>\n";
  }

  echo "<hr><h2>Filtyper</h2>\n";

  // Liste over filtype. Hver filtype har sin egen tabel med alle bogtitler.
  reset($packs);
  while (list($type,$attr) = each($packs)) {
    echo "<a name=\"".rawurlencode($type)."\"></a><h3>$type</h3>\n";
    echo "<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\" bgcolor=\"#E0F8F8\">\n<tr>\n";
    echo "<th>B�ger</th>\n";
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
        echo "<td align=\"right\">$filesize</td>\n";
      echo "</tr>\n";
    }
    echo "</table>\n";
  }

?>
<!-- Text slut -->
<!-- Husk din email-adresse: -->
<?php
  include($DOCUMENT_ROOT."includes/top.phtml");
?>
<center>
<p>Denne side vedligeholdes af Hans Schou (&lt;<A HREF="mailto:chlor@sslug.dk">chlor@sslug.dk</a>&gt;)
<br><a href="<?php echo $PHP_SELF ?>?show_source=1">Se kildeteksten</a></p>
</center>
</BODY>
</HTML>
