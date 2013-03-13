<?php
require_once('/libs/Smarty.class.php');
require_once('Base.php');

class ESmarty extends Smarty{
    function __construct() {
        parent::__construct();
        
        $this->assign('BaseURL', Config::GetRootUrl());
        
        $this->assign('SiteCssUrl', $this->UrlCSS('Site.css'));
        $this->assign('LoggedIn', Security::IsUserLoggedIn());
        $this->assign('UserName', Security::GetUser());
    }
    
    public function UrlCSS($resourceName){
        return Config::GetRootUrl().'/css/'.$resourceName;
    }
}
?>
