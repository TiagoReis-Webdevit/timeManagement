component {

	public struct function trimFields( struct fields = {} ) {

		for( var field in fields ) {
			field = trim( field );
		}

        return fields;

	}

}