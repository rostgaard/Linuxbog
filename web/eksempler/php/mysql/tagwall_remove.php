<?php
	# Sletter en besked fra tabellen, beskedens ID overføres via URL'en

	# Inkluderer filen config.php der indeholder databasens navn, brugernavn og
	# password til databasen, det gør det meget lettere at rette senere
	include("config.php");

	# Åbner en forbindelse til MySQL serveren
	# Hvis det mislykkes skrives "Could not connect"
	$messages_link = mysql_connect(_MYSQL_SERVER_NAME, _MYSQL_USER_NAME, _MYSQL_PASSWORD) 
		or die ("Could not connect\n");

	# Vælger den rigtige database
	# Hvis det mislykkes skrives "Could not select database"
	mysql_select_db ("FTAV") 
		or die ("Could not select database\n");

	# Gør en SQL forespørgsel klar.
	$query = "DELETE FROM Messages WHERE ID = '$ID'";

	# SQL forespørgslen udføres og resultat gemmes i $result
	$result = mysql_query($query);

	# Undersøger om forespørgslen fejlede
	if($result == 0) {
		print "Sletning mislykkedes\n";
	}

	# Forbindelsen til MySQL serveren lukkes
	mysql_close($messages_link);

	# Sender brugeren tilbage til besked siden...
	header("Location: tagwall.php");
?>
