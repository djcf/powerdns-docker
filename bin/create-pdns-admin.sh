#!/bin/bash
echo "Adding a new powerdns admin"
echo "---"
echo "Username: "
read username
echo "Password: "
read password
echo "Enter the name of the powerdns admin container (assumed powerdns_admin_1): "
read container || container='powerdns_admin_1'

docker stop $container
docker run --rm --volumes-from $powerdns_admin_1 pdns_admin python create_admin.py "$username" "$password"
docker start powerdns_admin_1