<html>
	<head>
		<title>Example of For Loop</title>
	</head>
	<body>
		<?
			echo ("<Table align=center border=1>");
			for($j=1; $j<=4; $j++){
				echo("<tr>");
				for($k=1;$k<=2;$k++){
					echo("<td> Line $j, Cell $k </td>");
				}
				echo("</tr>");
			}
			echo("</table>");
		?>
	</body>
</html>