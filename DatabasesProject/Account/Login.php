<?php
    require_once('/home/gq/gq011/public_html/project/Base.php');
    $smarty = new ESmarty;
    
    $smarty->setTemplateDir('/home/gq/gq011/public_html/project/templates/Account');
    $smarty->display('Login.tpl');
?>
