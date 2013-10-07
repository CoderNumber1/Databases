{extends file="/home/gq/gq011/public_html/project/templates/_Layout.tpl"}

{block name=body}
<fieldset>
    <legend>Student Homepage</legend>
    
    <div class="form-horizontal">
	  <div class="control-group">
		<label class="control-label">Student Id:</label>
		<div class="controls">
		  <p>{$StudentId}</p>
		</div>
	  </div>
	  <div class="control-group">
		<label class="control-label">Name:</label>
		<div class="controls">
		  <p>{$Name}</p>
		</div>
	  </div>
	  <div class="control-group">
		<label class="control-label">Age:</label>
		<div class="controls">
		  <p>{$Age}</p>
		</div>
	  </div>
	  <div class="control-group">
		<label class="control-label">Address:</label>
		<div class="controls">
		  <p>{$Address1}</p>
		</div>
	  </div>
	  <div class="control-group">
		<label class="control-label"></label>
		<div class="controls">
		  <p>{$Address2}</p>
		</div>
	  </div>
	  <div class="control-group">
		<label class="control-label">Type:</label>
		<div class="controls">
		  <p>{$Type}</p>
		</div>
	  </div>
	  <div class="control-group">
		<label class="control-label">Status:</label>
		<div class="controls">
		  <p>{$Status}</p>
		</div>
	  </div>
	</div>
</fieldset>

<div class="modal hide fade" id="modUpdateUser">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h3>User Info</h3>
  </div>
  <div class="modal-body">
      <input type="hidden" id="hdnMode"/>
    <div class="control-group">
        <label class="control-label" for="txtEditUserName">User Name</label>
        <div class="controls">
            <input type="text" id="txtEditUserName" placeholder="User Name"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="chkEditIsStudent">Is Student</label>
        <div class="controls">
            <input type="checkbox" id="chkEditIsStudent"/>
        </div>
    </div>
      
    <div class="control-group">
      <label class="control-label" for="chkEditIsAdmnistrator">Is Administrator</label>
      <div class="controls">
          <input type="checkbox" id="chkEditIsAdmnistrator"/>
      </div>
    </div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    <button id="btnUpdateUser" class="btn btn-primary">Save</button>
    <button id="btnResetUserPassword" class="btn">Reset Password</button>
  </div>
</div>

<div class="modal hide fade" id="modPasswordReset">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h3>Password Reset</h3>
  </div>
  <div class="modal-body">
      <p id="PasswordResultText"></p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>
{/block}