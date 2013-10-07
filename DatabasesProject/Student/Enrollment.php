<?php
    require_once('/home/gq/gq011/public_html/project/Base.php');
    Security::VerifySession(PermissionType::Student);
    
    $smarty = new ESmarty;
    
	$smarty->assign('PageType', 'Student');
    $smarty->setTemplateDir('/home/gq/gq011/public_html/project/templates/Student');
    $smarty->display('Enrollment.tpl');
?>