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
                        {if $HasStudentPermissions}<li class="dropdown{if $PageType eq 'Student'}active{/if}">
							<a id="StudentDropdown" role="button" class="dropdown-toggle" data-toggle="dropdown" href='#'>Student <b class="caret"></b></a>
							<ul class="dropdown-menu" role="menu" aria-labelledby="StudentDropdown">
								<li role="presentation"><a role="menuitem" tabindex="-1" href="{$BaseURL}/Student/Student.php">Home</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1" href="{$BaseURL}/Student/StudentCourses.php">Student Courses</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1" href="{$BaseURL}/Student/CourseInfo.php">Course Info</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1" href="{$BaseURL}/Student/Enrollment.php">Enrollment</a></li>
							</ul>
						</li>{/if}
                        {if $HasAdminPermissions}<li {if $PageType eq 'Admin'}class="active"{/if}><a href='{$BaseURL}/Administrator/Administrator.php'>Admin</a></li>{/if}
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
