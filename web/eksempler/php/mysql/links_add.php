<?php
	# $Id$
	# ----------------------------------------------------
	# Tilføjer en besked ti tabellen
	# ----------------------------------------------------

	# Inkluderer filen config.php der indeholder databasens navn, brugernavn og
	# password til databasen, det gør det meget lettere at rette senere
	include("config.php");

	# Åbner en forbindelse til MySQL serveren
	# Hvis det mislykkes skrives "Could not connect"
	$messages_link = mysql_connect(_MYSQL_SERVER_NAME, _MYSQL_USER_NAME, _MYSQL_PASSWORD) 
		or die ("Could not connect\n");

	# Vælger den rigtige database
	# Hvis det mislykkes skrives "Could not select database"
	mysql_select_db("FTAV", $messages_link)
		or die ("Could not select database\n");

	# Sætter indholdet af formen ind i tabellen
	$SQLQuery  = "insert into Links (Bruger, Link, Beskrivelse, Kategori) ";
	$SQLQuery .= "VALUES ('$form_user', '$form_link', '$form_beskrivelse', '$form_kategori')";
	$result = mysql_query($SQLQuery)
		or die ("Fejl i SQLQuery");

	# Lukker forbindelsen til databasen
	mysql_close($messages_link);

	# Sender brugeren tilbage til link siden...
	header("Location: links.php");
?>
