<html>
<!-- af Hans Schou -->
<h1>Opret SQL til Gæstebog</h1>

<p>CVS: $Id$</p>

<p>
<a href="<?php echo $PHP_SELF ?>?drop=1">Klik her, hvis tabeller først skal droppes</a>.
</p>

<p>
Kan man ikke få en kommandolinie på web-serveren, kan man i stedet bruge
PHP til at oprette og nedlægge SQL-tabeller.
Når du har oprettet tabellerne, <b>skal du slette dette script</b>, ellers
kommer der sikkert nogen og sletter dine tabeller.
</p>

<hr>
<?php

// Da dette script også ligger hos SSLUG, stoppes scriptet med følgende linier.
if ($REMOTE_ADDR != "127.0.0.1") {
  echo "<h1>Hov!</h1>";
  echo "Af sikkerhedsmæssige årsager kan dette script kun køres via localhost.";
  echo "Prøv igen <a href=\"http://localhost$PHP_SELF\">http://localhost$PHP_SELF</a>";
  echo "<br>eller slet denne funktion i scriptet på linie: ".__LINE__;
  exit;
}

// *************************************************************

// For at sikre at ingen laver numre med os, nulstilles $a
$a = array();

if ($drop) {
  $a[] = "DROP TABLE gaest";
  $a[] = "DROP SEQUENCE gaest_gid_seq";
}

// Opret tabel
$a[] = "CREATE TABLE gaest(
  gid     serial,
  opdat   timestamp NOT NULL DEFAULT 'now',
  vises   bool NOT NULL DEFAULT 'f',
  navn    text NOT NULL,
  email   text,
  hilsen  text
)";

// Et index til at sortere poster efter dato
$a[] = "CREATE INDEX gaest_opdat ON gaest(opdat)";

// Et et lille eksempel på en post, så der er noget at kikke på
$a[] = "INSERT INTO gaest(vises,navn,email,hilsen)
VALUES('t', 'Mig Selv', 'joe@aol.com', 'Hej mig selv, så er vi igang')";

// Vis poster i tabellen
$a[] = "SELECT * FROM gaest WHERE vises ORDER BY opdat DESC";

// *************************************************************

// Lille funktion til at vise en tabel.
function display_result( $res ) {
  echo "</pre><table border=\"1\" cellspacing=\"0\"><tr>\n";
  for ($n=0; $n<pg_numfields($res); $n++) {
    echo "<th>".pg_fieldname($res,$n)."</th>";
  }
  echo "</tr>\n";
  for ($n=0; $n<pg_numrows($res); $n++) {
    echo "<tr>";
    $arr = pg_fetch_row($res, $n);
    while (list(,$item) = each($arr))
      echo "<td>$item</td>";
    echo "</tr>\n";
  }
  echo "</table><pre>";
}

$error = array();

// Hovedprogram. Udfører alle statements i '$a'
require(".password.php");
$conn = pg_connect("dbname=$dbname");
echo "<pre>";
while (list(,$sql) = each($a)) {
  echo "$sql ; \n";
  $res = pg_exec($conn, $sql);
  if (pg_errormessage($conn))
    $error[$sql] = pg_errormessage($conn);
  if (pg_numrows($res))
    display_result($res);
  pg_freeresult($res);
  echo "\n";
  flush();
}
echo "</pre>";
pg_close($conn);

// Hvis der var fejl, listes de samlet her
if (count($error)) {
  echo "<h1>Fejl, SQL-statements ikke udført:</h1><pre>";
  while (list($sql,$err) = each($error))
    echo "<b>IN :</b>$sql\n<b>OUT:</b> $err\n";
  echo "</pre>";
} else {
  echo "<h1>Alt OK! Alle SQL-statements er udført</h1>";
}

?>
</html>
