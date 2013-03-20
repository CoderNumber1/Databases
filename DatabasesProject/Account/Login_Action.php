<?php
require_once('/home/gq/gq011/public_html/project/Base.php');

$userName = $_POST["userName"];
$password = $_POST["password"];

//Meaning the fields were either empty or null
if(strlen($userName) == 0 || strlen($password) == 0){
    header('location: Login.php?error=true'); //take them back to the page to fix errors.
}
else{
    //This is where we will need to validate the input against sql.
    
    if(Security::Authenticate($userName, $password)){
        Security::LoginSession($userName);

        header('location:'.Config::GetRootUrl());
    }
    else{
        header("location: Login.php?error=true"); //take them back to the page to fix errors.
    }
}
?>
