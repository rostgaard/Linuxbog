<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
        "http://www.w3.org/TR/REC-html40/loose.dtd">
<!-- $Id$ -->
<html>
<head>
<title>Min gæstebog</title>
</head>
<body bgcolor="white">

<?php

  // Hent password
  require(".password.php");
  // Åben forbindelse til databasen
  $conn = pg_pconnect("dbname=$dbname user=$dbuser");

  $sql = "SELECT opdat,navn,email,hilsen FROM gaest ORDER BY opdat DESC";
  $res = pg_exec($conn, $sql );
  for ($n=0; $n <pg_numrows($res); $n++ ) {
    list($opdat,$navn,$email,$hilsen) = pg_fetch_row($res, $n);
    echo "<h1>$navn &lt;$email&gt;</h1>";
    echo "<i>$opdat</i><br>";
    echo $hilsen;
  }
  pg_freeresult($res);

  pg_close($conn);

?>
</body></html>
