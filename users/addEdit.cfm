<cfscript>
	param url.usrId = 0;

	local.userDAO = new users.dao();

	if ( form.keyExists('submit') ) {
		switch ( form.submit ) {
			case 'Submit':
				try {
					if ( form.username.isEmpty() || form.email.isEmpty() )
						throw ( type="Validation", message="Please fill in all fields." );

					if ( !isValid( 'email', form.email ) )
						throw ( type="Validation", message="Email is not valid." );

					local.getUsers = local.userDAO.read( usrEmail = form.email, notUsrId = url.usrId );

					if ( local.getUsers.recordCount )
						throw ( type="Validation", message="Email already exists." );

					//Update user to database
					if ( url.keyExists( 'usrId' ) ) {
						local.userDAO.update(
							usrId = url.usrId,
							usrName = form.username,
							usrEmail = form.email
						);

					// Add user to database
					} else {
						if ( form.password.isEmpty() || form.confirmPassword.isEmpty() )
							throw ( type="Validation", message="You need to populate the password or confirm password field." );

						if ( form.password != form.confirmPassword )
							throw ( type="Validation", message="Password and confirm password is different." );

						local.salt = CreateUUID();
						local.password = hash( form.password & local.salt );

						url.usrId = local.userDAO.save(
							usrName = form.username,
							usrPassword = local.password,
							usrEmail = form.email,
							usrSalt = local.salt
						);
					}

					location ( url="addEdit.cfm?usrId=#url.usrId#", addToken=false );

					writeOutput( "User added." );

				} catch ( any e ) {
					writeOutput( "An errour as ocorrued: #e.message#." );
				}
			break;

			case 'Delete':
				local.userDAO.delete( usrId = url.usrId );

				location ( url="addEdit.cfm", addToken=false );

				writeOutput( "User deleted." );
			break;
		}
	}

	local.user = {
		usrId: 0,
		usrName: "",
		usrEmail: "",
		usrPassword: ""
	}

	if ( url.usrId > 0 ) {
		local.query = local.userDAO.read( usrId = url.usrId );

		if ( local.query.recordCount ) {
			local.user = local.query;
		}
	}
</cfscript>

<cfoutput>
    <h2>Add/Edit User</h2>

	<form name="addEditUser" method="post">
		<input type="hidden" name="action" value="addEdit">

		<table>
			<tr><td>
				<label for="username">Username:</label>
				<input type="text" name="username" id="username" value="#local.user.usrName#">
			</td></tr>

			<cfif url.usrId EQ 0>
				<tr><td>
					<label for="password">Password:</label>
					<input type="password" name="password" id="password" value="">
				</td></tr>

				<tr><td>
					<label for="password">Confirm Password:</label>
					<input type="password" name="confirmPassword" id="confirmPassword" value="">
				</td></tr>
			<cfelse>
				<tr><td>
					<a href="setPassword.cfm?usrId=#local.user.usrId#">Change Password</a>
				</td></tr>
			</cfif>

			<tr><td>
				<label for="email">Email:</label>
				<input type="text" name="email" id="email" value="#local.user.usrEmail#">
			</td></tr>

			<tr><td>
				<input type="submit" name="submit" value="Submit">
				<input type="submit" name="submit" value="Delete">

				<a href="list.cfm">List Users</a>
			</td></tr>
		</table>
	</form>
</cfoutput>