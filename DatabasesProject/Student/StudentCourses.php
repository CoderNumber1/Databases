<?php
    require_once('/home/gq/gq011/public_html/project/Base.php');
    Security::VerifySession(PermissionType::Student);
    
    $smarty = new ESmarty;
    
    $smarty->setTemplateDir('/home/gq/gq011/public_html/project/templates/Student');
    
	$repo = new UserRepository;
	$student = $repo->GetStudent(Security::GetClient()->UserName, null);
	$summary = $repo->GetStudentSummary($student[0]);
	$allCourses = $repo->GetStudentClasses($student[0], 'A');
	$currentCourses = $repo->GetStudentClasses($student[0], 'C');
	$takenCourses = $repo->GetStudentClasses($student[0], 'P');
	
	$smarty->assign('CourseCount', $summary[0]);
	$smarty->assign('CreditsEarned', $summary[1]);
	$smarty->assign('GPA', $summary[2]);
    $smarty->assign('AllCourses', $allCourses);
	$smarty->assign('CurrentCourses', $currentCourses);
	$smarty->assign('TakenCourses', $takenCourses);
    $smarty->display('StudentCourses.tpl');
?>