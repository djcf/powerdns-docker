#!/bin/sh
if [ -f /data/config.py ]; then
	echo "Copying custom config.py..."
	cp /data/config.py /src/
fi
if [ ! -f /data/padmin.sqlite ]; then
	echo "Creating PowerDNS-Admin database..."
	touch /data/padmin.sqlite
	python create_db.py
	python create_admin.py admin "$ADMIN_PASSWORD"
fi
mkdir -p /data/uploads
chown -R nobody /data

exec sudo -u nobody python run.py