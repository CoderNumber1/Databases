<?php

class Config
{
    public static $WebUrl = "http://localhost/databasesproject";
    public static $AppRoot = "c:\\_git\\databases\\databasesproject";
    public static $AppName = "DatabasesProject";
    
    public static function GetRootUrl(){
        return "http://$_SERVER[HTTP_HOST]/".Config::$AppName;
    }
}
?>
