<?
// set up environment
//putenv("ORACLE_HOME= /u01/app/oracle/product/11.2.0/dbhome_1");
//putenv("ORACLE_SID=orcl");

// setup connection with Oracle
$connection = oci_connect ("gq011", "hodzos", "gqian:1521/orcl");
if ($connection == false){
   echo oci_error()."<BR>";
   exit;
}

// define an SQL command and store it in a variable $query

$query="update faculty set worksfor = 'EE'".
         "where facssno = '000000010'";

// define a cursor for the SQL command stored in the variable $query.

$cursor = oci_parse ($connection, $query);
if ($cursor == false){
  echo oci_error($connection)."<BR>";
  exit;
}

// run the cursor 

$result = oci_execute ($cursor, OCI_NO_AUTO_COMMIT);
if ($result == false){
   echo oci_error($cursor)."<BR>";
   exit;
}

// commit the result
oci_commit ($connection);

// close the connection with oracle
oci_close ($connection);

echo ("Record updated.");

?>