<?php
    require_once('/home/gq/gq011/public_html/project/Base.php');
    Security::VerifySession(PermissionType::Administrator);
    
    $smarty = new ESmarty;
    
    $smarty->setTemplateDir('/home/gq/gq011/public_html/project/templates/Administrator');
    
    $repo = new UserRepository;
    if($_POST['getAll'] == true){
        $students = $repo->GetAllUsers();
    }
    else{
        $userName = $_POST['userName'];
        $isStudent = null;
        if(isset($_POST['isStudent'])){
            $isStudent = $_POST['isStudent'] == 'true' ? 1 : null;
        }
        
        $isAdministrator = null;
        if(isset($_POST['isAdministrator'])){
            $isAdministrator = $_POST['isAdministrator'] == 'true' ? 1 : null;
        }
        
        $students = $repo->GetUsers($userName, $isStudent, $isAdministrator);
    }
    
    $smarty->assign('Results', $students);
    $smarty->display('Administrator_Search.tpl');
?>