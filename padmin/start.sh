#!/bin/sh
if [ -f /data/config.py ]; then
	echo "Copying custom config.py..."
	cp /data/config.py /src/
fi
if [ ! -f /data/padmin.sqlite ]; then
	echo "Creating PowerDNS-Admin database..."
	touch /data/padmin.sqlite
#	sqlite3 /data/padmin.sqlite "CREATE DATABASE powerdnsadmin;"
#        sqlite3 /data/padmin.sqlite "GRANT ALL PRIVILEGES ON powerdnsadmin.* TO powerdnsadmin@'%' IDENTIFIED BY '1234';"
	python create_db.py
	python create_admin.py admin "$ADMIN_PASSWORD"
fi
mkdir -p /data/uploads
chown -R nobody /data

exec sudo -u nobody python run.py
