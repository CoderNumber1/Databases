<?php
require_once('/home/gq/gq011/public_html/project/libs/Smarty.class.php');
require_once('/home/gq/gq011/public_html/project/Base.php');

class ESmarty extends Smarty{
    function __construct() {
        parent::__construct();
        
        $this->use_sub_dirs = false;
        $this->setCompileDir('/home/gq/gq011/public_html/project/templates_c');
        $this->setTemplateDir('/home/gq/gq011/public_html/project/templates');
        
        $this->assign('BaseURL', Config::GetRootUrl());
        
        $this->assign('SiteCssUrl', Config::GetUrlCss('Site.css'));
        $this->assign('BootstrapCssUrl', Config::GetUrlCss('bootstrap.css'));
        $this->assign('JQueryUrl', Config::GetUrlJS('JQuery.js'));
        $this->assign('BootstrapJsUrl', Config::GetUrlJS('bootstrap.min.js'));
		$this->assign('PageType', 'None');
        
        $client = Security::GetClient();
        
        $this->assign('LoggedIn', Security::IsUserLoggedIn());
        
        if($client != null){
            $this->assign('UserName', $client->userName);
            $this->assign('HasStudentPermissions', Security::Authorize(PermissionType::Student));
            $this->assign('HasAdminPermissions', Security::Authorize(PermissionType::Administrator));
            $this->assign('AccessLevel', Security::GetPermissionLevel());
        }
    }
}
?>
