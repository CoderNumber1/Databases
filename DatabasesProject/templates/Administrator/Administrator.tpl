{extends file="/home/gq/gq011/public_html/project/templates/_Layout.tpl"}

{block name=body}
<script type="text/javascript">
    var Search = null;
    
    function EditUser(event){
        var detailParent = $(this).parents('.userDetail').first();
        $('#txtEditUserName').val(detailParent.find('.userNameDetail').first().attr('data-user-name')).prop('readonly', true);
        $('#chkEditIsStudent').prop('checked', detailParent.find('.isStudentDetail').first().attr('data-is-student') == 'true');
        $('#chkEditIsAdmnistrator').prop('checked', detailParent.find('.isAdministratorDetail').first().attr('data-is-administrator') == 'true');
        $('#hdnMode').val('Update');
    
        $('#modUpdateUser').modal('toggle');
    }
    
    function CreateUser(event){
        $('#txtEditUserName').val('').prop('readonly', false);
        $('#chkEditIsStudent').prop('checked', false);
        $('#chkEditIsAdmnistrator').prop('checked', false);
        $('#hdnMode').val('Create');
        
        $('#modUpdateUser').modal('toggle');
    }
    
    function DeleteUser(event){
        var detailParent = $(this).parents('.userDetail').first();
        var userName = detailParent.find('.userNameDetail').first().attr('data-user-name');
        
        SaveUserChanges(userName, null, null, 'Delete');
    }
    
    function Save(event){
        SaveUserChanges($('#txtEditUserName').val()
                        , $('#chkEditIsStudent').prop('checked')
                        , $('#chkEditIsAdmnistrator').prop('checked')
                        , $('#hdnMode').val());
    }
    
    function SaveUserChanges(userName, isStudent, isAdministrator, mode){
        $.ajax({
            url: 'Administrator_CRUD.php'
            , type: 'POST'
            , data: {
                UserName: userName
                , IsStudent: isStudent
                , IsAdministrator: isAdministrator
                , Mode: mode
            }
            , success: function(data){
                $('#btnAll').click();
            }
        });
    }
    
    function ResetPassword(event){
        var userName = $('#txtEditUserName').val();
        
        $.ajax({
            url: 'Administrator_ResetPassword.php'
            , type: 'POST'
            , datatype: 'json'
            , data: {
                userName: userName
            }
            , success: function(data){
                if(data.success == 1){
                    $('#PasswordResultText').empty().html('Password reset to ' + data.password + '.');               
                }
                else{
                    $('#PasswordResultText').empty().html('Password reset failed.');
                }
                
                $('#modPasswordReset').modal('toggle');
            }
        });
        
        $('#modUpdateUser').modal('toggle');
    }
    
    function SetUpUserButtons(){
        $('.recordUpdate').click(EditUser);
        $('.recordDelete').click(DeleteUser);
    }
    
    $('document').ready(function(){
        $.ajaxSetup({
            cache:false
        });
        
        $('#btnResetUserPassword').click(ResetPassword);
        $('#btnUpdateUser').click(Save);
        $('#btnCreate').click(CreateUser);
    
        $('#btnSearch').click(function(){
            Search = 'Search';
        
            $.ajax({
                url: 'Administrator_Search.php'
                , type: 'POST'
                , datatype: 'html'
                , data: {
                    userName: $('#txtUserName').val()
                    , isStudent: $('#chkStudents').prop('checked')
                    , isAdministrator: $('#chkAdministrators').prop('checked')
                }
                , success: function(data){
                    $('#SearchResults').empty().append(data);
                    SetUpUserButtons();
                }
            });
        });
        
        $('#btnAll').click(function(){
            Search = 'All';
            
            $.ajax({
                url: 'Administrator_Search.php'
                , type: 'POST'
                , datatype: 'html'
                , data: {
                    getAll: true
                }
                , success: function(data){
                    $('#SearchResults').empty().append(data);
                    SetUpUserButtons();
                }
            });
        });
    });
</script>
<fieldset>
    <legend>User Administration</legend>
    
    <div class="form-inline">
        <input id="txtUserName" type="text" class="input-small" placeholder="User Name" />
        <label class="checkbox">
          <input id="chkStudents" type="checkbox"/> Students
        </label>
        <label class="checkbox">
          <input id="chkAdministrators" type="checkbox"/> Administrators
        </label>
        <button id="btnSearch" class="btn">Search</button>
        <button id="btnAll" class="btn">Get All</button>
        <button id="btnCreate" class="btn">Create User</button>
    </div>
</fieldset>

<fieldset>
    <legend>Search Results</legend>
    
    <div id="SearchResults"></div>
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