<?php
    require_once('/home/gq/gq011/public_html/project/Base.php');
    Security::VerifySession(PermissionType::Administrator);
    
    $success = false;
    $repo = new UserRepository;
    if(isset($_POST['userName'])){
        $repo->SetPassword($_POST['userName'], 'password');
        $repo->InvalidateSessions($_POST['userName']);
        $success = true;
    }
        
    header('Content-Type: application/json');
    echo json_encode(array('success' => $success, 'password' => 'password'));
?>
