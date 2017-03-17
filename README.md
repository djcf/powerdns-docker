# powerdns-docker
[PowerDNS](https://www.powerdns.com/) & [PowerDNS-Admin](https://github.com/ngoduykhanh/PowerDNS-Admin) docker images

Forked from https://github.com/dzervas/powerdns-docker. Optimized for simpler configuration and also both images now use Alpine.

## Usage
After cloning the repository, just run `docker-compose up -d`

To create a new administrator (run the image once to create the database, before attempting to create an admin):
```
docker-compose stop powerdns_admin_1
docker run --rm --volumes-from powerdns_admin_1 pdns_admin python create_admin.py myusername mypassword
docker-compose restart powerdns_admin_1
```

## Convenience shell scripts

`create-pdns-admin.sh` will interactively create a new powerdns admin for you, following above. Just run it and go!

`pdns-cli.sh` is a wrapper into the pdns CLI utility. Full documentation here: https://blog.powerdns.com/2016/02/02/powerdns-authoritative-the-new-old-way-to-manage-domains/

## TODO

* An ansible script to install DNS master
* A new slave container image and
* Ansible plays to install it and configure slaves to talk to the master
* Ansible installation play should also upload domain information for the PDNS web interface domains