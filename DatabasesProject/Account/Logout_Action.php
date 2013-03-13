<?php
require_once('../Base.php');

Security::LogoutSession();
    
header('location:'.Config::GetRootUrl());
?>
