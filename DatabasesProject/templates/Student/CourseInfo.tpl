{extends file="/home/gq/gq011/public_html/project/templates/_Layout.tpl"}

{block name=body}
<fieldset>
    <legend>Course Information</legend>
    
	<table class="table table-striped table-condensed table-bordered">
		<thead>
			<tr>
				<th>Section Id</th>
				<th>Course Id</th>
				<th>Course Title</th>
				<th>Description</th>
				<th>Semester</th>
				<th>Year</th>
				<th>Time</th>
				<th>Credits</th>
			</tr>
		</thead>
		<tbody>
			{foreach from=$Courses item=user key=i} 
				<tr class="userDetail">
					<td>{$user['SECTIONID']}</td>
					<td>{$user['COURSEID']}</td>
					<td>{$user['TITLE']}</td>
					<td>{$user['DESCRIPTION']}</td>
					<td>{$user['SEMESTER']}</td>
					<td>{$user['TERMYEAR']}</td>
					<td>{$user['COURSETIME']}</td>
					<td>{$user['CREDITS']}</td>
				</tr> 
			{/foreach}
		</tbody>
	</table>
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