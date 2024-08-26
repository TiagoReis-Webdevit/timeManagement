component {

	this.datasource = 'timeManagement';
	this.db = 'jdbc:mysql://localhost:4306';
	this.dbUser = 'timeManagement???';
	this.dbPassword = 'timeManagement???';
    this.lib = expandPath( './lib' );

	public void function onRequestStart() {

        for( var field in form ) {
            form[field] = trim( form[field] );
		}

        form = this.lib.trimFields( form );

		for( var field in url ) {
            url[field] = trim( url[field] );
		}

        url = this.lib.trimFields( url );
	}

}