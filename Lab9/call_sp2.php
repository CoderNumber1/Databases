<?
$connection = oci_connect ("gq011", "hodzos", "gqian:1521/orcl");
if ($connection == false){
   echo oci_error()."<BR>";
   exit;
}

// the statement to call the stored procedure
$query = "begin " .
         " firstThree(:my_seqid, :my_average); " .
        "end;";

$cursor = oci_parse($connection, $query);
if ($cursor == false){
   echo oci_error($connection)."<BR>";
   exit;
}

// after parsing, bind the variable with Oracle variable.
oci_bind_by_name($cursor, ":my_seqid", &$my_seqid, 5);
oci_bind_by_name($cursor, ":my_average", &$my_average, -1);
$my_seqid = '00001';

$result = oci_execute($cursor, OCI_NO_AUTO_COMMIT);
if ($result == false){
   echo oci_error($cursor)."<BR>";
   exit;
}

oci_commit($connection);
oci_close($connection);

echo("Average Grade: $my_average");
?>
