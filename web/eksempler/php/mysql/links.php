<html>
<head>
<title>Side med links...</title>
</head>

<body>

<H1>Links</H1>
<table border = "0">
	<tr>
		<th width="200"><strong>Kategori / Link</strong></th>
		<th width="15">&nbsp; </th>
		<th width="400"><strong>Beskrivelse</strong></th>
	</tr>

<?php
	require("config.php");

	$link_link = mysql_connect(_MYSQL_SERVER_NAME, _MYSQL_USER_NAME, _MYSQL_PASSWORD)
		or die("Could not connect\n");

	mysql_select_db("FTAV", $link_link)
		or die("Could not select database\n");

	$SQL_Query  = "SELECT Link, Beskrivelse, ID, Kategori FROM Links ";
	$SQL_Query .= "ORDER BY Kategori, Link, ID";

	$Query = mysql_query($SQL_Query)
		or die("Query failed\n");

	$Query_length = mysql_num_rows($Query);

	$Link_type_old = "";

	for($i = 0; $i < $Query_length; $i++)
	{
		$Link        = mysql_result($Query, $i, "Link");
		$Description = mysql_result($Query, $i, "Beskrivelse");
		$ID          = mysql_result($Query, $i, "ID");
		$Link_type   = mysql_result($Query, $i, "Kategori");
		$Link_clean  = ereg_replace('http://', '', $Link);

		if($Link_type != $Link_type_old) {
			echo "	<tr>\n";
			echo "		<td colspan='3'><strong>$Link_type</strong></td>\n";
			echo "	</tr>\n";

			$Link_type_old = $Link_type;
		} else {
			echo "	<td></td>";
		}
		echo "	<tr>\n";

		echo "		<td><a href='http://" . $Link_clean . "'>" . $Link_clean . "</a></td>\n";
		echo "		<td align='right'><a href='links_remove.php?ID=$ID'>x</a></td>\n";
		echo "		<td>$Description</td>\n";
		echo "	</tr>\n";
	}
?>

</table>

<H2>Mangler der et link?</H2>
<form method=get action='links_add.php'>
<table>
	<tr>
		<td width = "100"></td>
		<td></td>
	</tr>
	<tr>
		<td>Link</td>
		<td><input type=text name=form_link></td>
	</tr>
	<tr>
		<td>Beskrivelse</td>
		<td><input type=text name=form_beskrivelse></td>
	</tr>
	<tr>
		<td>Link type</td>
		<td><input type=text name=form_kategori></td>
	</tr>
	<tr>
		<td></td>
		<td><input type=submit></td>
	</tr>
</table>
</form>

</body>
</html>

