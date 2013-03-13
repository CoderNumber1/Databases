<?php /* Smarty version Smarty-3.1.13, created on 2013-03-12 23:21:24
         compiled from ".\templates\test.tpl" */ ?>
<?php /*%%SmartyHeaderCode:32637513eb3e1da9fa1-47627751%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '0594836b2f92d8e84839a5d7cb15dd557ef50425' => 
    array (
      0 => '.\\templates\\test.tpl',
      1 => 1363118073,
      2 => 'file',
    ),
    'db9ec6ae0235d6be2b019e5b401c068c7946f654' => 
    array (
      0 => '.\\templates\\_Layout.tpl',
      1 => 1363152078,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '32637513eb3e1da9fa1-47627751',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_513eb3e1e2afd1_12886800',
  'variables' => 
  array (
    'SiteCssUrl' => 0,
    'LoggedIn' => 0,
    'UserName' => 0,
    'BaseURL' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_513eb3e1e2afd1_12886800')) {function content_513eb3e1e2afd1_12886800($_smarty_tpl) {?><!DOCTYPE html>
<html>
    <head>
        <title>Databases</title>
        
        <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css" rel="stylesheet">
        <link href="<?php echo $_smarty_tpl->tpl_vars['SiteCssUrl']->value;?>
" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <div class="navbar">
                <div class="navbar-inner">
                    <a class="brand" href="#">Project</a>

                    <?php if ($_smarty_tpl->tpl_vars['LoggedIn']->value){?>
                        <p class="pull-right">Welcome: <?php echo $_smarty_tpl->tpl_vars['UserName']->value;?>
, <a href="<?php echo $_smarty_tpl->tpl_vars['BaseURL']->value;?>
/Account/Logout_Action.php">logout</a></p>
                    <?php }?>
                </div>
            </div>

            
<p>This is the test page.</p>


            <div class="navbar navbar-fixed-bottom">
                <p>This is the footer.</p>
            </div>
        </div>
    </body>
</html>
<?php }} ?>