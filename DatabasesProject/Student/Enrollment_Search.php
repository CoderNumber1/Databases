<?php
    require_once('/home/gq/gq011/public_html/project/Base.php');
    Security::VerifySession(PermissionType::Student);
    
    $smarty = new ESmarty;
    
    $smarty->setTemplateDir('/home/gq/gq011/public_html/project/templates/Student');
    
    $repo = new UserRepository;
	$courseId = $_POST['courseId'];
	$semester = $_POST['semester'];
	
	$courses = $repo->CourseSearch($courseId, $semester);
    
    $smarty->assign('Results', $courses);
    $smarty->display('Enrollment_Search.tpl');
?>