<?php
require_once('/home/gq/gq011/public_html/project/Base.php');
require_once('/home/gq/gq011/public_html/project/DataModels/UserRepository.php');
Security::VerifySession(PermissionType::Administrator);

if(isset($_POST['Mode'])){
    $repo = new UserRepository;
    
    $mode = $_POST['Mode'];
    $userName = $_POST['UserName'];
    $isStudent = $_POST['IsStudent'] == 'true' ? 1 : 0;
    $isAdministrator = $_POST['IsAdministrator'] == 'true' ? 1 : 0;
    
    if($mode == 'Create'){
        $repo->CreateUser($userName, $isStudent, $isAdministrator);
    }
    else if($mode == 'Update'){
        $repo->UpdateUser($userName, $isStudent, $isAdministrator);
    }
    else if($mode == 'Delete'){
        $repo->InvalidateSessions($userName);
        $repo->DeleteUser($userName);
    }
}
?>
