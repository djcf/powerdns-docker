# powerdns-docker
[PowerDNS](https://www.powerdns.com/) & [PowerDNS-Admin](https://github.com/ngoduykhanh/PowerDNS-Admin) docker images

Forked from https://github.com/dzervas/powerdns-docker. Optimized for simpler configuration and also both images now use Alpine.

## Usage
### Using ansible
This should be the easiest way, but its completely untested at the moment.

1. It relies on https://github.com/Nosmoht/ansible-module-powerdns, an ansible module for talking to powerdns which is located in the lib directory. So make sure to clone the repository with submodules when you do. Try `git clone --recusrive git@github.com:djcf/powerdns-docker.git` instead of the normal `git clone`.
2. Just edit the dns-inventory.yml file so it reflects your desired infrastructure. It's advised to use ns0. as the PDNS master, and ns1-4 and slaves.
3. Edit pdns-api.yml and seed it with desired random values.
4. Then run `ansible-playbook -i dns-inventory.yml ansible-install.yml`

Finished!

### Using docker-compose
If you don't want to use ansible, you can run the containers one at a time. This is how you would do it if you don't want the full auto-deployed infrastructure with slaves. So after cloning the repository, edit docker-compose.yml and make sure it has the desired values for API key etc. Then run `docker-compose up -d`.

**You can also deploy slaves the same way.** Just run `docker-compose -f docker-compose-slave.yml up -d` instead.

### Using docker

Not normally recomended -- use docker-compose instead.

Try something like this:

    docker build -t powerdns powerdns
    docker run -d -p 53:53 -p 53:53/udp -e PDNS_TYPE=master -e API_KEY=1234 -e VIRTUAL_HOST=powerdns.fqdn powerdns

And for powerdns admin:

    docker build -t powerdns_admin padmin
    docker run -d -e PDNS_TYPE=master -e API_KEY=1234 -e VIRTUAL_HOST=dnsadmin.fqdn -e ADMIN_PASSWORD=xxx powerdns_admin

Finally, the following should work for the slaves:

    docker build -t powerdns powerdns
    docker run -d -p 53:53 -p 53:53/udp -e PDNS_TYPE=slave -e MASTER_DNS=f.q.d.n -e MASTER_IP=i.p. powerdns

## PowerDNS Admin
Once you have the powerdns admin container up and running, you can add more admins using the `bin/create-pdns-admin.sh` script. The initial username is `admin` with whatever password you set the `ADMIN_PASSWORD` environment variable to be.

PowerDNS admin is a great project, find out more about it here: https://github.com/ngoduykhanh/PowerDNS-Admin

## Convenience shell scripts

In the `bin` directory. If you use ansible, they get installed to /usr/local/bin.
 
`create-pdns-admin.sh` will interactively create a new powerdns admin for you. Just run it and go!

`pdns-cli.sh` is a wrapper into the pdns CLI utility. Full documentation here: https://blog.powerdns.com/2016/02/02/powerdns-authoritative-the-new-old-way-to-manage-domains/

# Configuring the PDNS backends
## Using environment variables
We can tell docker-compose to put powerdns configuration into pdns.conf at run-time. Make sure your docker-compose.yml file looks like this:

    environment:
        CONFIG: "ldap_binddn,ldap_secret,ldap_basedn"
        ldap_basedn=xxx
        ldap_binddn=yyy
        ldap_secret=1234

In order for the `ldap_secret`, `ldap_basdn`, etc. to be added to `pdns.conf` at runtime as `ldap-secret`, `ldap-basedn` you must tell the init script which variables to include. This is the purpose of $CONFIG.

Note that you can configure any type of config here. For example:

    environment:
        CONFIG: "master"
        master=yes

**NOTE that all powerdns config values containing hyphens should instead contain underscores, as above.**

Once you have changed the powerdns config like this, you only have to run `docker-compose up -d`.

## Using .conf files
This is super simple and easy. Basically just put the config relating to the backends in `powerdns/$backend.conf`. Then in docker-compose.yml or your docker run command, specify the environment such that `PDNS_BACKENDS` is a string of comma-separated PDNS backends, to be passed into the pdns.conf file as `launch=$PDNS_BACKENDS`.

For example, your `powerdns/ldap.conf` file could contain:

    ldap-host=ldap://ldap/

And your `powerdns/gsqlite3.conf` file could contain:

    gsqlite3-database=/etc/pdns/run/sqlite3/zone_db.sqlite

With this configuraiton, your docker-compose.yml file should contain:

    environment:
        PDNS_BACKENDS: "gsqlite3,ldap"

Once you have changed the config files, you **must** rebuild the image. All files named like `*.conf` in `powerdns` directory will be added to the image by the Dockerfile build script.

## TODO

* Only need to test it now...