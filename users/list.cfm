<cfscript>
	local.userDAO = new users.dao();

	local.listOfUsers = local.userDAO.read();
</cfscript>

<cfoutput>
	<h2>List Users</h2>
	<table border="1">
		<tr><td>
			Username:
		</td><td>
			Email:
		</td><td>
			Actions:
		</td></tr>

		<cfloop query="#local.listOfUsers#">
			<tr><td>
				#usrName#
			</td><td>
				#usrEmail#
			</td><td>
				<a href="addEdit.cfm?usrId=#usrId#">Edit</a>
			</td></tr>
		</cfloop>
	</table>
</cfoutput>