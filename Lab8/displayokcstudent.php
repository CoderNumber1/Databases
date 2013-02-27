<?
// setup connection with Oracle
$connection = oci_connect ("gq011", "hodzos", "gqian:1521/orcl");
if ($connection == false){
   echo oci_error()."<BR>";
   exit;
}

// this is the SQL command to be executed
$query = "select SNAME, SSNO, STULEVEL from STUDENT where CURADDRESS = 'OKC'";
// parse the SQL command
$cursor = oci_parse ($connection, $query);
if ($cursor == false){
   echo oci_error($connection)."<BR>";
   exit;
}

// execute the command
$result = oci_execute ($cursor);
if ($result == false){
  echo oci_error($cursor)."<BR>";
  exit;
}

// display the results
echo "<table border=1>";
echo "<tr> <th>Name</th> <th>SSN</th> <th>Level</th></tr>";

// fetch the result from the cursor one by one
while ($values = oci_fetch_array ($cursor)){
  $name = $values[0];
  $ssn = $values[1];
  $level = $values[2];
  
  echo "<tr><td>$name</td> <td>$ssn</td> <td>$level</td></tr>";
}

echo "</table>";

// free up resources used by the cursor
oci_free_statement($cursor);

// close the connection with oracle
oci_close ($connection);
?>
