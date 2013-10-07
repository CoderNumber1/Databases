<?php
require_once('/home/gq/gq011/public_html/project/Base.php');
require_once('/home/gq/gq011/public_html/project/DataModels/UserRepository.php');
Security::VerifySession(PermissionType::Administrator);

if(isset($_POST['sectionId'])){
    $repo = new UserRepository;
	$studentRecord = $repo->GetStudent(Security::GetClient()->UserName, null);
	$repo->LockEnrollment();
	$result = $repo->Enroll($studentRecord[0], $_POST['sectionId']);
	
	if($result["flag"] == false){
		echo($result["error"]);
	}
}
else{
	echo("No course selected");
}
?>
