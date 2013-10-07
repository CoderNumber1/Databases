<?php
    require_once('/home/gq/gq011/public_html/project/Base.php');
    Security::VerifySession(PermissionType::Student);
    
    $smarty = new ESmarty;
	$repo = new UserRepository;
	
	$studentRecord = $repo->GetStudent(Security::GetClient()->UserName, null);
    
	$smarty->assign('StudentId', $studentRecord[0]);
	$smarty->assign('Name', $studentRecord[1]." ".$studentRecord[2]);
	$smarty->assign('Age', $studentRecord[3]);
	$smarty->assign('Address1', $studentRecord[4]);
	$smarty->assign('Address2', $studentRecord[5].", ".$studentRecord[6]." ".$studentRecord[7]);
	$smarty->assign('Type', $studentRecord[8]);
	$smarty->assign('Status', $studentRecord[9] == 1 ? "Probational" : "Non-Probational");
	
	$smarty->assign('PageType', 'Student');
    $smarty->setTemplateDir('/home/gq/gq011/public_html/project/templates/Student');
    $smarty->display('Student.tpl');
?>