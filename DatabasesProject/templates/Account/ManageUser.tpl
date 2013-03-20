{extends file="/home/gq/gq011/public_html/project/templates/_Layout.tpl"}

{block name=body}
<form method="POST" action="Change_Password_Action.php" class="form-horizontal">
    <fieldset>
        <legend>Change Password</legend>
        
        <div class="control-group">
            <label class="control-label" for="oldPassword">Old Password</label>
            <div class="controls">
                <input type="text" id="oldPassword" name="oldPassword" placeholder="Old Password">
            </div>
        </div>
        
        <div class="control-group">
            <label class="control-label" for="newPassword">New Password</label>
            <div class="controls">
                <input type="text" id="newPassword" name="newPassword" placeholder="New Password">
            </div>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Change Password</button>
        </div>
    </fieldset>
</form>
{/block}