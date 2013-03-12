<?php
    require('/libs/Smarty.class.php');
    
    $smarty = new Smarty;

    $smarty->assign('title', 'Hello World');
    $smarty->assign('hello', 'Hello World, this is my first smarty!');
    $smarty->display('test.tpl');
?>