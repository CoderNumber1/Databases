<table class="table table-striped table-condensed table-bordered">
    <thead>
        <tr>
            <th>Section Id</th>
            <th>Course Id</th>
            <th>Title</th>
            <th>Semester</th>
            <th>Year</th>
			<th>Credits</th>
			<th>Time</th>
			<th>Max Seats</th>
			<th>Seats Filled</th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$Results item=user key=i} 
            <tr>
                <td>{$user['SECTIONID']}</td>
                <td>{$user['COURSEID']}</td>
                <td>{$user['TITLE']}</td>
				<td>{$user['SEMESTER']}</td>
				<td>{$user['TERMYEAR']}</td>
				<td>{$user['CREDITS']}</td>
				<td>{$user['COURSETIME']}</td>
				<td>{$user['MAXSEATS']}</td>
				<td>{$user['SEATSFILLED']}</td>
            </tr> 
        {/foreach}
    </tbody>
</table>