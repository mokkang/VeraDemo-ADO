#!/bin/sh

set -e

if [ "$1" = 'Pipeline' ]; then
	# Drop the first argument
	shift 1
	exec java -jar $APPROOT/$APP \
	    -vid $VERACODE_API_ID \
		-vkey $VERACODE_API_KEY \
		"$@" 
fi

exec "$@"
