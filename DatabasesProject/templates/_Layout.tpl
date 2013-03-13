<!DOCTYPE html>
<html>
    <head>
        <title>{block name=title}Databases{/block}</title>
        
        <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css" rel="stylesheet">
        <link href="{$SiteCssUrl}" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <div class="navbar">
                <div class="navbar-inner">
                    <a class="brand" href="#">Project</a>

                    {if $LoggedIn}
                        <p class="pull-right">Welcome: {$UserName}, <a href="{$BaseURL}/Account/Logout_Action.php">logout</a></p>
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
