#!/bin/ash
if [ ! -f /etc/pdns/run/sqlite3/zone_db.sqlite ]; then
	echo "Creating PowerDNS database..."
	touch /etc/pdns/run/sqlite3/zone_db.sqlite
	sqlite3 /etc/pdns/run/sqlite3/zone_db.sqlite < /pdns/create_db.sql
fi

chown pdns:pdns /etc/pdns/run/sqlite3/ -R

exec pdns_server --daemon=no --allow-recursion=172.17.0.0/24 \
	--disable-axfr=yes --local-address=0.0.0.0 --launch=gsqlite3 \
	--gsqlite3-database=/etc/pdns/run/sqlite3/zone_db.sqlite --api=yes \
	--api-key="$API_KEY" --webserver=yes --webserver-address=0.0.0.0 \
	--webserver-port=80 --webserver-password="$WEBSERVER_PASSWORD" "$@"