<?php
# af Hans Schou 2003

	$mailto = "linuxbog@sslug.dk";

	if (preg_match("|/([^/]+)/[^/]+/([^/]+)\.html|", $_SERVER["REQUEST_URI"], $match)) {
		$bognavn = $match[1];
		$id = $match[2];
		$output = exec("cd ../../ ; egrep -Hin 'id=\"?$id\"?' $bognavn/*.sgml");
		list($sgmlfile, $linenumber) = split(":", $output);
		#echo "<pre>vi $sgmlfile +$linenumber</pre>\n";
	}

	if ($HTTP_POST_VARS["tekst"]) {
		$tekst = stripcslashes($HTTP_POST_VARS["tekst"]);
		$email = $HTTP_POST_VARS["email"];
		$reply = ($email ? $email : $mailto);
		$subject = "[FTAV] ".$_SERVER["REQUEST_URI"]." $email";
		$body = "\nForslag til rettelse fra e-mail: $email\n";
		$body .= "Afsendt fra IP-nummer: ".$_SERVER["REMOTE_ADDR"]."\n";
		$body .= "HTML-fil:\nhttp://".$_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"]."\n";
		if ($sgmlfile) {
			$body .= "SGML-fil:\nvi $sgmlfile +$linenumber\n";
		}
		$body .= "\n";
		$body .= "-------- Teksten --------\n";
		$body .= "$tekst\n";
		$body .= "-------- Teksten --------\n";
		$body .= "\n\nEOF";
		mail( $mailto,
			$subject,
			$body,
			"From: ftav-edit@".$_SERVER["SERVER_NAME"]."\r\n"
			."Reply-To: $reply\r\n"
			."X-Mailer: PHP/".phpversion()
		);

		echo "<hr><blockquote>\n";
		echo "Følgende mail er sendt til $mailto:\n<pre>Subject: $subject\n";
		echo htmlentities($body)."</pre>\n";
		echo "</blockquote>\n";
	}
?>
<!--
Her starter "/submit.inc" af Hans Schou.
$Id$

For at bruge dette script, skal du indsætte
	< ?php include($DOCUMENT_ROOT."/submit.inc") ?>
i bunden af din .html fil.
Dernæst skal din fil have tilføjet .php til slut i filnavnet.
-->
<hr>
<h2>Rettelser</h2>
<p>Har du en rettelse til denne side, så skriv den i boksen herunder.
Din besked bliver sendt til redaktionen af <i>Friheden Til At Vælge</i>.
</p>
<form action="<?php echo $_SERVER["REQUEST_URI"] ?>" method="post">
<p>
Eventuelt din e-mail adresse:
<input type="text" name="email" value="<?php echo $HTTP_POST_VARS["email"] ?>">
<br>
(E-mail er kun nødvendig hvis du ønsker svar.)
<br>
Din kommentar eller rettelse:
<br>
<textarea name="tekst" cols="60" rows="10">
<?php echo stripcslashes($HTTP_POST_VARS["tekst"]) ?>
</textarea>
<input type="submit" name="submit" value="Submit">
</form>
<p>Dit IP-nummer er <?php echo $_SERVER["REMOTE_ADDR"] ?>.</p>
<!-- Her slutter "submit.inc" -->
