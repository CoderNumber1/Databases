{extends file="/home/gq/gq011/public_html/project/templates/_Layout.tpl"}

{block name=body}
<form method="POST" action="Login_Action.php" class="form-horizontal">
    <fieldset>
        <legend>Log In</legend>
        
        <div class="control-group">
            <label class="control-label" for="userName">User Name</label>
            <div class="controls">
                <input type="text" id="userName" name="userName" placeholder="User Name">
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
{/block}