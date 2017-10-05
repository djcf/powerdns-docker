#!/bin/ash
if [ ! -f /etc/pdns/run/sqlite3/zone_db.sqlite ]; then
	echo "Creating PowerDNS database..."
	touch /etc/pdns/run/sqlite3/zone_db.sqlite
	sqlite3 /etc/pdns/run/sqlite3/zone_db.sqlite < /pdns/create_db.sql
	if [ "$PDNS_TYPE" == "slave" ]; then
		sqlite3 /etc/pdns/run/sqlite3/zone_db.sqlite 'insert into supermasters values ("$MASTER_IP", "$MASTER_DNS", "admin");'
		mv /etc/pdns/slave.conf /etc/pdns/pdns.conf
	fi
fi

chown pdns:pdns /etc/pdns/run/sqlite3/ -R

if [ "$PDNS_TYPE" == "master" ]; then
	exec pdns_server --allow-recursion=172.17.0.0/24 --local-address=0.0.0.0 --api-key="$API_KEY" --webserver-password="$WEBSERVER_PASSWORD" "$@"
fi

if [ "$PDNS_TYPE" == "slave" ]; then
	exec pdns_server 	--allow-recursion=172.17.0.0/24 \
						--local-address=0.0.0.0 \
						--allow-notify-from=$MASTER_IP \
						--allow-dnsupdate-from=$MASTER_IP \
						--allow-axfr-ips=$MASTER_IP \
						"$@"
fi
