#!/bin/sh
# if [ -f /data/config.py ]; then
# 	echo "Copying custom config.py..."
# 	cp /data/config.py /src/
# fi
# if [ ! -f /data/.db_created ]; then
# 	echo "Creating padmin db..."
# 	python /src/create_db.py admin "$ADMIN_PASSWORD" && touch /data/.db_created
# fi
if [ ! -f /data/.admin_created ]; then
	echo "Creating admin user..."
	python /src/create_admin.py admin "$ADMIN_PASSWORD" && touch /data/.admin_created
fi
# if [ ! -f /data/padmin.sqlite ]; then
# 	echo "Creating PowerDNS-Admin database..."
# 	touch /data/padmin.sqlite
# #	sqlite3 /data/padmin.sqlite "CREATE DATABASE powerdnsadmin;"
# #        sqlite3 /data/padmin.sqlite "GRANT ALL PRIVILEGES ON powerdnsadmin.* TO powerdnsadmin@'%' IDENTIFIED BY '1234';"
# 	python create_db.py
# 	python create_admin.py admin "$ADMIN_PASSWORD"
# fi
python run.py