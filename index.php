<?php
   // $Id$

   /* top.phtml sets 
      <!--DOCTYPE ....
      .....
      ... [topmenu] ...
   */
   $htmltitle_en="SSLUG - Liberty of writing books";
   $htmltitle_da="SSLUG - Friheden til at skrive bøger";
   $htmltitle_sv="SSLUG - Friheden til at skrive bøger";
   $bodyarg=" background=\"/grafix/linux-back-1.gif\" ";
   $maintain_name = "Hans Schou";       // Skriv dit navn her
   $maintain_email = "chlor@sslug.dk";  // Skriv din email adresse her
   include($DOCUMENT_ROOT."/includes/top.phtml");

   list($width,$height) = getimagesize("front.png");
?>

<img src="front.png" alt="Friheden til at skrive bøger"
 align="right" width="<? echo $width ?>" height="<? echo $height ?>">
<h1>SSLUG - Friheden til at skrive bøger</h1>

<?php

// Funktion til at lave hyperlink
function href($url,$desc) {
  return "<a href=\"$url\">$desc</a>";
}

// Returner filstørrelse i human readable format
function fsize_text( $filename ) {
  // ISO filstørrelser, ex: 5.5 MB
  $ISO = array("","k","M","G","T","P");
  $filesize = filesize($filename);
  if (! $filesize) {
      return "000 B";  // file_exists() skulle være checket her
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

  // Bøger
  $books = array(
    // Bognavn, forkortet
    "friheden" => array(
      title => "Linux - Friheden til at vælge",
      comment => "En god begynderbog",
      auth => array(
        "Peter Toft" => "pto@sslug.dk",
        "Hans Schou" => "chlor@sslug.dk"
      )
    ),
    "applikationer" => array(
      title => "Linux - Friheden til at vælge programmer",
      comment => "Vælg programmer til Linux",
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
      comment => "Programmering på Linux",
      auth => array(
        "Peter Toft" => "pto@sslug.dk",
        "Hans Schou" => "chlor@sslug.dk"
      )
    ),
    "sikkerhed" => array(
      title => "Linux - Friheden til sikkerhed på internettet",
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
    ),
  "alle" => array(
     title => "Linux - Friheden til at skrive bøger",
     comment => "Samling af alle bøgerne",
     auth => array(
       "Peter Toft" => "pto@sslug.dk",
       "Hans Schou" => "chlor@sslug.dk"
     )
   )
  );


  // Bogpakker pakket på forskellige måder
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
    "HTML zip" => array(
      first => "linux-",
      last => "_html.zip"
    ),
    "PNG billeder" => array(
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
    // Eks: linux-frihed-pdf.zip
    "PDF" => array(
      first => "linux-",
      last => "_pdf.zip"
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
<h2>Vi har følgende bøger</h2>
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

  // Pæn bullet liste over alle bog-titler med kort beskrivelse
  reset($books);
  while (list($short,$desc) = each($books)) {
    echo "<li><b>$short:</b> ";
    echo href("#$short","<b>$desc[title]</b>");
    echo "<br> $desc[comment]";
    echo "</li>\n";
  }
?>
</ul>
<p>

Benyt vores "Et-klik-service" for at downloade og læse bøgerne,
eller køb en indbundet udgave hos følgende forretninger:
<ul>
<li><a href="http://www.printxpress.dk/linuxbog/">PrintXpress</a></li>
<li><a href="http://www.pn-tryk.dk/html/linux.html">PN-tryk</a></li>
<li><a href="http://www.sc-birkeroed.dk/htm-sider/Linux.htm">SC-Birkerød</a></li>
</ul>
Bøgerne er udgivet under <a href="opl.shtml">OpenContent License</A>
hvilket gør at SSLUG ikke er involveret i de trykte udgaver.
<p>

Bøgerne kan også fås i
<a href="http://www.klid.dk/~cs">Microsoft Word format</a>.
<p>
Vil du se hvad der skete med kilde-SGML filerne, så se <a href="cvs2html/">her</a>.
<p>

<FORM METHOD="GET" ACTION="http://www.netmind.com/cgi-bin/uncgi/url-mind">
Vil du modtage E-post om nye versioner af bogen?
<BR>Skriv din E-post adresse her
<BR><INPUT TYPE=TEXT SIZE=40 NAME="required-email">
<BR><INPUT TYPE=HIDDEN VALUE="http://www.sslug.dk/linuxbog" NAME="url">
<INPUT TYPE=SUBMIT VALUE="Indsend form"></FORM>
<p>

Bøgerne redigeres af Peter Toft og Hans Schou
&lt;<a href="mailto:linuxbog@sslug.dk">linuxbog@sslug.dk</a>&gt;.
<br>
Indholdet af bøgerne diskuteres på
&lt;<a href="mailto:sslug-bog@sslug.dk">sslug-bog@sslug.dk</a>&gt;.
<p>

Der er altid ting vi gerne vil have skrevet om, eller skrevet mere på.<br>
Du er meget velkommen til at komme med forslag. 
<a href="todo.html">Vi efterlyser bla. disse ting</a>.

<p>

Vil du følge med i hvad der sker med vores kilde-kode (SGML-filerne), 
<a href="http://cvs.sslug.dk/linuxbog/">så se her</a>.


<p>

Hvis du har noget du søger efter, så skal du nok <a
href="alle/bog/stikord.html">starte i vores samlede
indeks-register.</a>


<p>
Har du fundet fejl i en bog, så send venligst dette til 
&lt;<a href="mailto:sslug-bog@sslug.dk">sslug-bog@sslug.dk</a>&gt;.<br>
Er du ikke medlem af SSLUG, så skriv til
&lt;<a href="mailto:linuxbog@sslug.dk">linuxbog@sslug.dk</a>&gt;.<br>
Vi foretrækker direkte rettelser foretaget i SGML-kildeteksten, men
kan også rette ud fra præcise angivelser for hvor rettelserne skal
foretages.
<hr>
<a name="matrix"></a>
<h2>Samlet bogoversigt</h2>
<table border="1" cellspacing="0" cellpadding="3">
<tr bgcolor="#F0F0FF"><th>Bøger/filtype</th>
<?php

  // Stor tabel med alle bøger og filtyper samlet.
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

  echo "<hr><h2>Bøger</h2>\n";

  // Liste over alle bøger. Alle bøger har hver sin tabel med forskellig filtyper
  reset($books);
  while (list($short,$desc) = each($books)) {
    echo "<a name=\"$short\"></a><h3>$desc[title] \n";
    echo "</h3>\n<i>$desc[comment]</i><p>";

    if (file_exists($short."/dato.sgml")) {
      include($short."/dato.sgml");
    }
    if (file_exists($short."/version.sgml")) {
      echo "- version ";
      include($short."/version.sgml");
    }
    if (file_exists($short."/sideantal.txt")) {
      echo "- Antal sider: ";
      include($short."/sideantal.txt");
    }
    echo "<p>";
    echo "<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\" bgcolor=\"#F8F8E0\">\n<tr>\n";
    echo "<th>Bøger</th>\n";
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
    echo "<p><hr align=\"left\" width=\"70%\">\n";
  }

  echo "<hr><h2>Filtyper</h2>\n";

  // Liste over filtype. Hver filtype har sin egen tabel med alle bogtitler.
  reset($packs);
  while (list($type,$attr) = each($packs)) {
    echo "<a name=\"".rawurlencode($type)."\"></a><h3>$type</h3>\n";
    echo "<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\" bgcolor=\"#E0F8F8\">\n<tr>\n";
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
        echo "<td align=\"right\">$filesize</td>\n";
      echo "</tr>\n";
    }
    echo "</table>\n";
  }

?>

<p>
<!-- Text slut -->
<!-- Husk din email-adresse: -->
<?php
  include($DOCUMENT_ROOT."/includes/bottom.phtml");
?>
