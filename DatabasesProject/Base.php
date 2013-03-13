<?php
    require_once('Smarty.php');
    require_once('Security.php');
    require_once('Config.php');
    
    //Only for debugging
    ini_set('display_errors', true);
    error_reporting(E_ALL + E_NOTICE);
    
    //Make sure we've got a session started so we can store user data.
    if(strlen(session_id()) == 0){
        session_start();
    }
?>
