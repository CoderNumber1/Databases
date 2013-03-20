<?php
    require_once('/home/gq/gq011/public_html/project/Smarty.php');
    require_once('/home/gq/gq011/public_html/project/Security.php');
    require_once('/home/gq/gq011/public_html/project/Config.php');
    
    //Only for debugging
    ini_set('display_errors', true);
    error_reporting(E_ALL + E_NOTICE);
    
    //Make sure we've got a session started so we can store user data.
    Security::EnsureSessionStarted();
?>
