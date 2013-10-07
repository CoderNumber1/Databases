<?php
    require_once('/home/gq/gq011/public_html/project/Base.php');
    Security::VerifySession(PermissionType::Student);
    
    $smarty = new ESmarty;
    
    $smarty->setTemplateDir('/home/gq/gq011/public_html/project/templates/Student');
    
	$repo = new UserRepository;
	$courses = $repo->GetCourses();
	
    $smarty->assign('Courses', $courses);
    $smarty->display('CourseInfo.tpl');
?>