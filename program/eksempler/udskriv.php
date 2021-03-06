<html><head><title>udskriv.php</title></head><body bgcolor="#FFFFFF">
<?php

/*
  udskriv.php
  af Hans Schou <chlor@sslug.dk>
  $Id$

  L�g programmet i /home/httpd/html/

  Afvikling: http://localhost/udskriv.php?filnavn=udskriv.php
*/

// PHP s�tter automatisk variable op, der angivet i URL'en
// Variablen $filnavn er s� lig med "udskriv.php" (dette program)
// For at sikre at man ikke l�se filer i f.eks. /etc, bruges "basename()"

	// Strip '$filnavn' for .. og /
	// Tildel $findfil det lokale filnavn, og test om den er der
	if (!file_exists($findfil = basename($filnavn)))
		echo "Fejl: filen '$findfil' eksisterer ikke i dette sub-directory";
	else {
		// Indl�s hele filen i et array
		$helfil = file(basename($findfil));
		// Send HTML-kode for fixed font
		echo "<pre>\n";
		// For alle linjer, udskriv linienummer og tekst
		while (list($linje,$tekst) = each($helfil))
			// htmlentities() s�rger for konvertering af special-tegn: <>&�
			echo "$linje: ".htmlentities($tekst);
		echo "</pre>\n";
	}

	// Web/CGI-programmer sender al data i een session.
	// Derfor kan der ikke ventes p� at der tastes 'Q' <ENTER>
?>
</body></html>
