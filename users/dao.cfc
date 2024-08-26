component {

	public numeric function create(
		required string usrName,
		required string usrPassword,
		required string usrEmail,
		required string usrSalt
	) {
		var sql = "
			INSERT INTO users (
				usrName,
				usrPassword,
				usrEmail,
				usrSalt
			) VALUES (
				:usrName,
				:usrPassword,
				:usrEmail,
				:usrSalt
			)
		";

		var params = {
			usrName: { value: arguments.usrName, sqltype: "varchar" },
			usrPassword: { value: arguments.usrPassword, sqltype: "varchar" },
			usrEmail: { value: arguments.usrEmail, sqltype: "varchar" },
			usrSalt: { value: arguments.usrSalt, sqltype: "varchar" }
		};

		queryExecute( sql.trim(), local.params, { result: 'query' } );

		return query.generatedKey;
	}

	public query function read(
		numeric usrId = 0,
		string usrEmail = "",
		numeric notUsrId = 0
	) {
		var sql = "
			SELECT *
			FROM users
			WHERE 1 = 1
		";

		var params = {};

		if ( arguments.usrId > 0 ) {
			sql &= " AND usrId = :usrId";

			params['usrId'] = { value: arguments.usrId, sqltype: "integer" };
		}

		if ( arguments.usrEmail.len() ) {
			sql &= " AND usrEmail = :usrEmail";

			params['usrEmail'] = { value: arguments.usrEmail, sqltype: "varchar" };
		}

		if ( arguments.notUsrId > 0 ) {
			sql &= " AND usrId != :notUsrId";

			params['notUsrId'] = { value: arguments.notUsrId, sqltype: "integer" };
		}

		return queryExecute( sql.trim(), params );
	}

	public void function update(
		required string usrName,
		required string usrEmail,
		required numeric usrId
	) {
		var sql = "
			UPDATE users SET
				usrName = :usrName,
				usrEmail = :usrEmail
			WHERE usrId = :usrId
		";

		var params = {
			usrName: { value: arguments.usrName, sqltype: "varchar" },
			usrEmail: { value: arguments.usrEmail, sqltype: "varchar" },
			usrId: { value: arguments.usrId, sqltype: "integer" }
		};

		queryExecute( sql.trim(), local.params );
	}

	public void function updatePassword(
		required string usrPassword,
		required string usrSalt,
		required numeric usrId
	) {
		var sql = "
			UPDATE users SET
				usrPassword = :usrPassword,
				usrSalt = :usrSalt
			WHERE usrId = :usrId
		";

		var params = {
			usrPassword: { value: arguments.usrPassword, sqltype: "varchar" },
			usrSalt: { value: arguments.usrSalt, sqltype: "varchar" },
			usrId: { value: arguments.usrId, sqltype: "integer" }
		};

		queryExecute( sql.trim(), local.params );
	}

	public void function delete(
		required numeric usrId
	) {
		var sql = "
			DELETE FROM users
			WHERE usrId = :usrId
		";

		var params = {
			usrId: { value: arguments.usrId, sqltype: "integer" }
		};

		queryExecute( sql.trim(), local.params );
	}
}