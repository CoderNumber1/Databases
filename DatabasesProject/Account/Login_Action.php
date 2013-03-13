<?php
require_once('../Base.php');

$clientId = $_POST["clientId"];
$password = $_POST["password"];

//Meaning the fields were either empty or null
if(strlen($clientId) == 0 || strlen($password) == 0){
    header('location: login.php?error=true'); //take them back to the page to fix errors.
}
else{
    //This is where we will need to validate the input against sql.
    
    $sessionId = md5(uniqid(rand()));
    Security::LoginSession($sessionId);
    
    header('location:'.Config::GetRootUrl());
}
?>
