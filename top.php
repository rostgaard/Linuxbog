<?php
if (!$ml)
	$ml = ($HTTP_HOST=="cvs.linuxbog.dk" ? "sg" : "ht");
?>
<form action="search.php" method="get">
Søg i
<input type=radio name=ml value="sg"<?php echo $ml=="sg"?" checked":"" ?>> SGML
<input type=radio name=ml value="ht"<?php echo $ml!="sg"?" checked":"" ?>> HTML
<br>
Søg efter:
<input type="text" name="q" value="" size="40">
<input type="submit" name="s" value="Submit">
</form>
<hr>
