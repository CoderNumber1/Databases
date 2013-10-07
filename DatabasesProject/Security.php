<?php
require_once('/home/gq/gq011/public_html/project/DataModels/UserRepository.php');

class Security{
    public static function EnsureSessionStarted(){
        if(strlen(session_id()) == 0){
            session_start();
            
            if(!isset($_SESSION['PermissionLevel'])){
                $_SESSION['PermissionLevel'] = PermissionType::None;
            }
        }
    }
    
    public static function VerifySession($permissionLevel = null){
        //TODO: contact sql to verify this information at some point.
        if(!Security::IsUserLoggedIn()){
            header('location: '.Config::GetRootUrl().'/Account/Login.php');
        }
        else if($permissionLevel != null && !Security::Authorize($permissionLevel)){
            header('location: '.Config::GetRootUrl());
        }
        else{
            $repo = new UserRepository;
            $sessionId = $repo->GetCurrentSession(Security::GetClient()->userName);
            
            if($sessionId != $_SESSION['SessionId']){
                Security::LogoutSession();
                
                header('location: '.Config::GetRootUrl().'/Account/Login.php');
            }
        }
    }

    public static function Authenticate($userName, $password){
        $repo = new UserRepository;
        
        if($repo->GetPassword($userName) == $password){
            return true;
        }
        else{
            return false;
        }
    }
    
    public static function Authorize($permissionLevel){
        if($permissionLevel == Security::GetPermissionLevel()){
            return true;
        }
        else if(($permissionLevel == PermissionType::Administrator
                || $permissionLevel == PermissionType::Student)
                && Security::GetPermissionLevel() == PermissionType::StudentAdministrator){
            return true;
        }
        else if($permissionLevel == PermissionType::Authenticated && Security::GetPermissionLevel() != PermissionType::None){
            return true;
        }
        else{
            return false;
        }
    }
    
    public static function LoginSession($userName){
        $repo = new UserRepository;
        $sessionId = md5(uniqid(rand()));
        
        $_SESSION['SessionId'] = $sessionId;
        
        $repo->InvalidateSessions($userName);
        $repo->CreateSession($userName, $sessionId);
        $sqlUser = $repo->GetUser($userName);

        //Here we need to associate the sessionId to a user.
        $client = new Client;
        $client->userName = $userName;
        $client->isStudent = $sqlUser[0] == 1;
        $client->isAdmin = $sqlUser[1] == 1;
        $_SESSION['Client'] = $client; //replace this with actual logic.
        
        if($client->isAdmin == 1 && $client->isStudent == 1){
            $_SESSION['PermissionLevel'] = PermissionType::StudentAdministrator;
        }
        else if($client->isAdmin == 1){
            $_SESSION['PermissionLevel'] = PermissionType::Administrator;
        }
        else if($client->isStudent == 1){
            $_SESSION['PermissionLevel'] = PermissionType::Student;
        }
        else{
            $_SESSION['PermissionLevel'] = PermissionType::Authenticated;
        }
    }
    
    public static function LogoutSession(){
        $repo = new UserRepository;
        $repo->InvalidateSessions(Security::GetClient()->userName);
        session_destroy();
    }

    public static function IsUserLoggedIn(){
        if(isset($_SESSION['SessionId'])){
            return true;
        }
        else{
            return false;
        }
    }

    public static function GetClient(){
        $client = $_SESSION['Client'];
        
        /* @var $client Client */
        return $client;
    }
    
    public static function GetPermissionLevel(){
        return $_SESSION['PermissionLevel'];
    }
}

class Client{
    public $userName;
    public $isStudent;
    public $isAdmin;
}

class PermissionType{
    const None = 0;
    const Authenticated = 1;
    const Student = 2;
    const Administrator = 3;
    const StudentAdministrator = 4;
}
?>
