<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
        "http://www.w3.org/TR/REC-html40/loose.dtd">
<!-- $Id$ -->
<html>
<head>
<title>Min gæstebog</title>
</head>
<body bgcolor="white">

<?php

function gem_denne($navn, $email, $hilsen ) {
  // Hent password
  require(".password.php");
  // Åben forbindelse til databasen
  $conn = pg_pconnect("dbname=$dbname user=$dbuser");

  $sql = "INSERT INTO gaest(navn,email,hilsen) VALUES('$navn', '$email', '$hilsen')";
  $res = pg_exec($conn, $sql );
  pg_freeresult($res);

  pg_close($conn);
}

// Test om der blev klikket 'Gem'
if ($aktion == "Gem") {
  echo "Hej <b>$navn</b><br>Tak fordi du skrev i min gæstebog.";
  gem_denne($navn, $email, $hilsen);
}

?>
</body></html>
