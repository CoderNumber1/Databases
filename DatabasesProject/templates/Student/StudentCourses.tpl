{extends file="/home/gq/gq011/public_html/project/templates/_Layout.tpl"}

{block name=body}
<fieldset>
	<legend>Student Summary</legend>
	
	<table class="table table-striped table-condensed table-bordered">
			<thead>
				<tr>
					<th>Course Count</th>
					<th>Credits Earned</th>
					<th>GPA</th>
				</tr>
			</thead>
			<tbody>
				<tr class="userDetail">
					<td>{$CourseCount}</td>
					<td>{$CreditsEarned}</td>
					<td>{$GPA}</td>
				</tr> 
			</tbody>
		</table>
</fieldset>

<fieldset>
    <legend>Student Courses</legend>
    
	<ul class="nav nav-tabs">
	  <li class="active"><a href="#all" data-toggle="tab">All</a></li>
	  <li><a href="#current" data-toggle="tab">Current</a></li>
	  <li><a href="#taken" data-toggle="tab">Taken</a></li>
	</ul>

	<div class="tab-content">
	  <div class="tab-pane active" id="all">
		<table class="table table-striped table-condensed table-bordered">
			<thead>
				<tr>
					<th>Section Id</th>
					<th>Course Id</th>
					<th>Course Title</th>
					<th>Semester</th>
					<th>Year</th>
					<th>Credits</th>
					<th>Grade</th>
				</tr>
			</thead>
			<tbody>
				{foreach from=$AllCourses item=user key=i} 
					<tr class="userDetail">
						<td>{$user['SECTIONID']}</td>
						<td>{$user['COURSEID']}</td>
						<td>{$user['TITLE']}</td>
						<td>{$user['SEMESTER']}</td>
						<td>{$user['TERMYEAR']}</td>
						<td>{$user['CREDITS']}</td>
						<td>{$user['GRADE']}</td>
					</tr> 
				{/foreach}
			</tbody>
		</table>
	  </div>
	  <div class="tab-pane" id="current">
		<table class="table table-striped table-condensed table-bordered">
			<thead>
				<tr>
					<th>Section Id</th>
					<th>Course Id</th>
					<th>Course Title</th>
					<th>Semester</th>
					<th>Year</th>
					<th>Credits</th>
					<th>Grade</th>
				</tr>
			</thead>
			<tbody>
				{foreach from=$CurrentCourses item=user key=i} 
					<tr class="userDetail">
						<td>{$user['SECTIONID']}</td>
						<td>{$user['COURSEID']}</td>
						<td>{$user['TITLE']}</td>
						<td>{$user['SEMESTER']}</td>
						<td>{$user['TERMYEAR']}</td>
						<td>{$user['CREDITS']}</td>
						<td>{$user['GRADE']}</td>
					</tr> 
				{/foreach}
			</tbody>
		</table>
	  </div>
	  <div class="tab-pane" id="taken">
		<table class="table table-striped table-condensed table-bordered">
			<thead>
				<tr>
					<th>Section Id</th>
					<th>Course Id</th>
					<th>Course Title</th>
					<th>Semester</th>
					<th>Year</th>
					<th>Credits</th>
					<th>Grade</th>
				</tr>
			</thead>
			<tbody>
				{foreach from=$TakenCourses item=user key=i} 
					<tr class="userDetail">
						<td>{$user['SECTIONID']}</td>
						<td>{$user['COURSEID']}</td>
						<td>{$user['TITLE']}</td>
						<td>{$user['SEMESTER']}</td>
						<td>{$user['TERMYEAR']}</td>
						<td>{$user['CREDITS']}</td>
						<td>{$user['GRADE']}</td>
					</tr> 
				{/foreach}
			</tbody>
		</table>
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