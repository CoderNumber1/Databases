<?php
class Security{
    public static function VerifySession(){
        //TODO: contact sql to verify this information at some point.
        if(!Security::IsUserLoggedIn()){
            header('location: Account/Login.php');
        }
    }

    public static function LoginSession($sessionId){
        $_SESSION['SessionId'] = $sessionId;

        //Here we need to associate the sessionId to a user.
        $_SESSION['User'] = 'User'; //replace this with actual logic.
    }
    
    public static function LogoutSession(){
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

    public static function GetUser(){
        return $_SESSION['User'];
    }
}
?>
