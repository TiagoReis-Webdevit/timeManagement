<cfscript>
	local.userDAO = new users.dao();

	if ( form.keyExists("action") ) {

		if ( form.action == "setPassword" ) {
			try {
				if ( form.password.isEmpty() || form.confirmPassword.isEmpty() )
					throw ( type="Validation", message="You need to populate the password or confirm password field." );

				if ( form.password != form.confirmPassword )
					throw ( type="Validation", message="Password and confirm password is different." );

				local.salt = CreateUUID();
				local.password = hash( form.password & local.salt );

				local.userDAO.updatePassword(
					usrId = url.usrId,
					usrPassword = local.password,
					usrSalt = local.salt
				);

				location ( url="addEdit.cfm?usrId=#url.usrId#", addToken=false );

				writeOutput( "User password was updated." );

			} catch ( any e ) {
				writeOutput( "An errour as ocorrued: #e.message#." );
			}
		}
	}
</cfscript>

<cfoutput>
    <h2>Set User Password</h2>

	<form name="setPasswordUser" method="post">
		<input type="hidden" name="action" value="setPassword">

		<table>
			<tr><td>
				<label for="password">Password:</label>
				<input type="password" name="password" id="password" value="">
			</td></tr>

			<tr><td>
				<label for="password">Confirm Password:</label>
				<input type="password" name="confirmPassword" id="confirmPassword" value="">
			</td></tr>

			<tr><td>
				<input type="submit" name="submit" value="Submit">
			</td></tr>
		</table>
	</form>
</cfoutput>