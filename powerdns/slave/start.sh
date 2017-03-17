#!/bin/ash
exec pdns_server --daemon=no --allow-recursion=172.17.0.0/24 \
	--api-key="$API_KEY" \
	--webserver-password="$WEBSERVER_PASSWORD" "$@"