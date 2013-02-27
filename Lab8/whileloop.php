<html>
	<head>
		<title>Example of While Loop</title>
	</head>
	<body>
		<?
			echo("<table align=center border=1>");
		
			$j=1;
			while($j<=4){
				echo("<tr>");
				
				$k=1;
				while($k<=2){
					echo("<td> Line $j, Cell $k </td>");
					$k++;
				}
				
				echo("</tr>");
				$j++;
			}
			
			echo("</table>");
		?>
	</body>
</html>