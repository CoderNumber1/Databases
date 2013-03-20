<?php

class Config
{
//    public static $WebUrl = "http://localhost/databasesproject";
//    public static $AppRoot = "c:\\_git\\databases\\databasesproject";
    public static $AppName = "~gq011/project";
    
    public static function GetRootUrl(){
        return "http://$_SERVER[HTTP_HOST]/".Config::$AppName;
    }
    
    public static function GetUrlCss($resourceName){
        return Config::GetRootUrl().'/css/'.$resourceName;
    }
    
    public static function GetUrlJS($resourceName){
        return Config::GetRootUrl().'/js/'.$resourceName;
    }
}
?>
