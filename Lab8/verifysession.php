<?
$sessionid =$_GET["sessionid"];

$clientid = ""; 

$connection = oci_connect ("gq011", "hodzos", "gqian:1521/orcl");

if($connection == false){
  echo oci_error()."<BR>";
  $sessionid=""; 
} 
else { 
  // connection OK - validate current sessionid 
  if (!isset($sessionid) or ($sessionid=="")) { 
    // no session to maintain 
    $sessionid=""; 
  }
  else{ 
    // lookup the sessionid in the session table to get the clientid 
    $sql = "select clientid " .
       "from clientsession " .
       "where sessionid='$sessionid'";  

    $cursor = oci_parse($connection, $sql);
    if($cursor == false){
      echo oci_error($connection)."<BR>";
      // query failed - login impossible
      $sessionid="";
    }
    else{       
      $result = oci_execute($cursor);
      if ($result == false){
        echo oci_error($cursor)."<BR>";
        $sessionid="";
      }
      else{
        if($values = oci_fetch_array ($cursor)){
          // found the sessionid
          $clientid = $values[0];
        } 
        else { 
          // invalid sessionid 
          $sessionid = ""; 
        } 
      } 
      oci_free_statement($cursor);
    }
  } 
  oci_close($connection);
} 
?>
