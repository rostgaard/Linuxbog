<html><head>
<?php
	$filename = "$file.$ext";
?>
<title><?php echo $filename ?></title></head>
<body bgcolor="#FFFFFF">
<?php
	require("proglang.inc");
	echo "<h1>".$proglang[$ext][navn]."</h1>\n";
	echo "<h2>Filnavn: $filename</h2>\n";
	echo "Læs mere om <b>".$proglang[$ext][navn]."</b> i bogen under ";
	echo "<a href=\"$boghref".$proglang[$ext][link]."\">http://$SERVER_NAME$boghref".$proglang[$ext][link]."</a>\n";
	echo "<p>\n";
	echo $examp[$file];
  echo "<p>Download <a href=\"$filename\">$filename</a>\n";
?>
<p>
<table border="0" cellspacing="0" width="80%" bgcolor="#F0F0F0">
<tr><td><pre>
<?php
  $fp = fopen(basename("$filename"),"r");
	while (!feof($fp)) {
		$s = fgets($fp, 1024);
		echo htmlentities($s);
  }
?>
</pre></td></tr>
</table>

</body></html>
