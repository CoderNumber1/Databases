<!DOCTYPE html>
<html>
    <head>
        <title>{block name=title}Databases{/block}</title>
        
        <link href="{$BootstrapCssUrl}" rel="stylesheet">
        <link href="{$SiteCssUrl}" rel="stylesheet">
        <script type="text/javascript" src="{$JQueryUrl}"></script>
        <script type="text/javascript" src="{$BootstrapJsUrl}"></script>
    </head>
    <body>
        <div class="container">
            <div class="navbar">
                <div class="navbar-inner">
                    <a class="brand" href="{$BaseURL}">Project</a>
                    
                    <ul class="nav">
                        {if $HasStudentPermissions}<li><a href='#'>Student</a></li>{/if}
                        {if $HasAdminPermissions}<li><a href='{$BaseURL}/Administrator/Administrator.php'>Admin</a></li>{/if}
                    </ul>

                    {if $LoggedIn}
                        <p class="pull-right">Welcome: <a href="{$BaseURL}/Account/ManageUser.php">{$UserName}</a>, <a href="{$BaseURL}/Account/Logout_Action.php">logout</a></p>
                    {/if}
                </div>
            </div>
            {block name=body}Hello World{/block}

            <div class="navbar navbar-fixed-bottom">
                <p>This is the footer.</p>
            </div>
        </div>
    </body>
</html>
