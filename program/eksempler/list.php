<html><head><title>Liste af alle sprog</title></head>
<h1>Liste af '<?php echo $file ?>' eksempler</h1>
<a href=".">Hovedliste</a>
<p>
Kender du blot et programmeringssprog som er på denne liste,
kan du se eksempler på hvordan man løser den samme opgave
i et andet sprog.
<p>
Har du aldrig prøvet at programmere, så er denne liste
nok mere forvirrende, end den er informativ.
<p>
<?php
	require("proglang.inc");

	// Skriv hvad dette er for en type program
	echo "<b>$file:</b> $examp[$file]";
	echo "<p>";
/*
	while (list($ext,$lang) = each($proglang)) {
		if (file_exists($filename = "$file.$ext")) {
			echo "<a href=\"$PHP_SELF?file=$file#$ext\">$lang->navn</a> ";
		}
	}
*/
	reset($proglang);
	while (list($ext,$lang) = each($proglang)) {
		if (file_exists($filename = "$file.$ext")) {
			echo "<hr><a name=\"$lang->navn\"></a>";
			echo "<h2>$lang->navn: <a href=\"show.php?file=$file&amp;ext=$ext\">$filename</a></h2>\n";
			echo "Læs mere om <b>".$proglang[$ext][navn]."</b> i bogen under ";
			echo "<a href=\"$boghref".$proglang[$ext][link]."\">http://www.sslug.dk$boghref".$proglang[$ext][link]."</a>\n";
			echo "<table border=\"0\" cellspacing=\"0\" width=\"80%\" bgcolor=\"#F0F0F0\">";
			echo "<tr><td><pre>";
  		$fp = fopen(basename($filename),"r");
			while (!feof($fp)) {
				$s = fgets($fp, 1024);
				echo htmlentities($s);
  		}
			echo "</pre></td></tr></table>\n";
		}
	}

?>
</body></html>
