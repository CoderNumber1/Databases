<?php
    require_once('/home/gq/gq011/public_html/project/Base.php');
    Security::VerifySession(PermissionType::Administrator);
    
    $smarty = new ESmarty;
    
	$smarty->assign('PageType', 'Admin');
    $smarty->setTemplateDir('/home/gq/gq011/public_html/project/templates/Administrator');
    $smarty->display('Administrator.tpl');
?>