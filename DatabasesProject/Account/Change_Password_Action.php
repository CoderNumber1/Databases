<?php
require_once('/home/gq/gq011/public_html/project/Base.php');
require_once('/home/gq/gq011/public_html/project/DataModels/UserRepository.php');
Security::VerifySession(PermissionType::Authenticated);

$oldPassword = $_POST['oldPassword'];
$newPassword = $_POST['newPassword'];

$success = false;

if(strlen($oldPassword) > 0 || strlen($newPassword) > 0){
    $client = Security::GetClient();
    if(Security::Authenticate($client->userName, $oldPassword)){
        $repository = new UserRepository;
        $repository->SetPassword($client->userName, $newPassword);
        
        $success = true;
    }
}

if($success){
    header('location: '.Config::GetRootUrl());
}
else{
    header('location: ManageUser.php?error=true');
}
?>
