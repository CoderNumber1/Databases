<html>
<head><title>Student Page</title></head>
<body>
<?
// fetch queryCno argument if any
$queryCno = $_POST["queryCno"];

// $queryCno is the variable holds the query condition
if(!isset($queryCno) or ($queryCno==""))
  $whereClause = " 1=1 ";
else{
  $queryCno = strtoupper($queryCno);
  $whereClause = " cno like '%$queryCno%' ";
}

// set up environment
//putenv("ORACLE_HOME=/home/oracle/OraHome1");
//putenv("ORACLE_SID=orcl");

$connection = oci_connect ("gq011", "hodzos", "gqian:1521/orcl");
if($connection == false){
  echo oci_error()."<BR>";
  exit;
}    

// processing queries based on course number
// note that the variable queryCno is passed to the file
// multi.php itself and processed at the beginning of the file
echo("<FORM name=\"queryCourse\" method=\"POST\" action=\"multi.php\"> " .
     "Course No: <INPUT type=\"text\" name=\"queryCno\"> " .
     "<INPUT type=\"submit\" name=\"btnSubmit\" value=\"Query\"> " .
     "</FORM>"); 

// the query string
$query = "select cno, credits from CourseDescription where " . $whereClause;

$cursor = oci_parse ($connection, $query);
if ($cursor == false){
  echo oci_error($connection)."<BR>";
  exit; 
}

$result = oci_execute ($cursor);
if ($result == false){
  echo oci_error($cursor)."<BR>";
  exit;
}

// the form to process the selected courses
// the selected course numbers are in array cnoList[]
// and passed to proc.php
echo "<form action=\"proc.php\" method=\"post\">";
echo "<table border=1>";
echo "<tr><td><b>Course No</b></td>" .
     "<td><b>Credits</b></td>" .
     "<td> </td></tr>";  

// fetch the result from the cursor one by one
while ($values = oci_fetch_array ($cursor)){
  $cno = $values[0];
  $credits = $values[1];
  echo "<tr><td>$cno</td>" .
       "<td>$credits</td>" .
       "<td><input type=\"checkbox\" name=\"cnoList[]\" value=\"$cno\"></td>" .
       "</tr>";
}
echo "</table>";
echo "<INPUT type=\"submit\" name=\"btnSubmit\" value=\"Proc\">";
echo "</form>";

oci_free_statement($cursor);

// close the connection with oracle
oci_close ($connection);
?>
</body>
</html>
