<?php
    require_once('Base.php');
    Security::VerifySession();
    
    $smarty = new ESmarty;

    $smarty->assign('title', 'Hello World');
    $smarty->assign('hello', 'Hello World, this is my first smarty!');
    $smarty->display('test.tpl');
?>