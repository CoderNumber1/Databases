<?php /* Smarty version Smarty-3.1.13, created on 2013-03-13 12:04:30
         compiled from "c:\_git\databases\databasesproject\templates\Account\login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:26589513f96295fac31-61987365%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '517ea3791f18542ae2bbce32fb225feea2abe67b' => 
    array (
      0 => 'c:\\_git\\databases\\databasesproject\\templates\\Account\\login.tpl',
      1 => 1363149354,
      2 => 'file',
    ),
    '732716a284d6992c6de9b50e44ac15d0c083d2f5' => 
    array (
      0 => 'c:\\_git\\databases\\databasesproject\\templates\\_Layout.tpl',
      1 => 1363197804,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '26589513f96295fac31-61987365',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_513f96296b7c74_14904841',
  'variables' => 
  array (
    'BootstrapCssUrl' => 0,
    'SiteCssUrl' => 0,
    'HasStudentPermissions' => 0,
    'HasAdminPermissions' => 0,
    'LoggedIn' => 0,
    'UserName' => 0,
    'BaseURL' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_513f96296b7c74_14904841')) {function content_513f96296b7c74_14904841($_smarty_tpl) {?><!DOCTYPE html>
<html>
    <head>
        <title>Databases</title>
        
        <link href="<?php echo $_smarty_tpl->tpl_vars['BootstrapCssUrl']->value;?>
" rel="stylesheet">
        <link href="<?php echo $_smarty_tpl->tpl_vars['SiteCssUrl']->value;?>
" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <div class="navbar">
                <div class="navbar-inner">
                    <a class="brand" href="#">Project</a>
                    
                    <ul class="nav">
                        <?php if ($_smarty_tpl->tpl_vars['HasStudentPermissions']->value){?><li><a href='#'>Student</a></li><?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['HasAdminPermissions']->value){?><li><a href='#'>Admin</a></li><?php }?>
                    </ul>

                    <?php if ($_smarty_tpl->tpl_vars['LoggedIn']->value){?>
                        <p class="pull-right">Welcome: <?php echo $_smarty_tpl->tpl_vars['UserName']->value;?>
, <a href="<?php echo $_smarty_tpl->tpl_vars['BaseURL']->value;?>
/Account/Logout_Action.php">logout</a></p>
                    <?php }?>
                </div>
            </div>

            
<form method="POST" action="Login_Action.php" class="form-horizontal">
    <fieldset>
        <legend>Log In</legend>
        
        <div class="control-group">
            <label class="control-label" for="clientId">Client Id</label>
            <div class="controls">
                <input type="text" id="clientId" name="clientId" placeholder="Client Id">
            </div>
        </div>
        
        <div class="control-group">
            <label class="control-label" for="password">Password</label>
            <div class="controls">
                <input type="password" id="password" name="password" placeholder="Password">
            </div>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Log In</button>
        </div>
    </fieldset>
</form>


            <div class="navbar navbar-fixed-bottom">
                <p>This is the footer.</p>
            </div>
        </div>
    </body>
</html>
<?php }} ?>