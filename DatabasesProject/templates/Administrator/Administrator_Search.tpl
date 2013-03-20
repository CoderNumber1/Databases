<table class="table table-striped table-condensed table-bordered">
    <thead>
        <tr>
            <th>User Name</th>
            <th>Is Student</th>
            <th>Is Administrator</th>
            <th></th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$Results item=user key=i} 
            <tr class="userDetail">
                <td class="userNameDetail" data-user-name="{$user['USERNAME']}">{$user['USERNAME']}</td>
                <td class="isStudentDetail" data-is-student="{$user['ISSTUDENT']}">{$user['ISSTUDENT']}</td>
                <td class="isAdministratorDetail" data-is-administrator="{$user['ISSTUDENT']}">{$user['ISADMINISTRATOR']}</td>
                <td><button class="btn recordUpdate">Update</button></td>
                <td><button class="btn recordDelete">Delete</button></td>
            </tr> 
        {/foreach}
    </tbody>
</table>