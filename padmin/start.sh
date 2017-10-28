#!/bin/sh
# if [ -f /data/config.py ]; then
# 	echo "Copying custom config.py..."
# 	cp /data/config.py /src/
# fi
if [ ! -f /data/.admin_created ]; then
	python create_admin.py admin "$ADMIN_PASSWORD"
	touch /data/.admin_created
fi

python run.py