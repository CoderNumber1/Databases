<?php
    require('../Smarty.php');
    require_once('../config.php');
    $smarty = new ESmarty;
    
    ini_set('display_errors', true);
    error_reporting(E_ALL + E_NOTICE);
    
//    $smarty->use_sub_dirs = false;
    $smarty->setTemplateDir(Config::$AppRoot."\\templates");
    $smarty->assign('URL', Config::GetRootUrl());
    $smarty->display('Account/login.tpl');
?>

<!--$_SERVER[REQUEST_URI]-->
