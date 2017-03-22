# powerdns-docker
[PowerDNS](https://www.powerdns.com/) & [PowerDNS-Admin](https://github.com/ngoduykhanh/PowerDNS-Admin) docker images

Forked from https://github.com/dzervas/powerdns-docker. Optimized for simpler configuration and also both images now use Alpine.

## Usage
### Using ansible
This is the easiest way. 

1. It relies on https://github.com/Nosmoht/ansible-module-powerdns, an ansible module for talking to powerdns which is located in the lib directory. So make sure to clone the repository with submodules when you do. Try `git clone --recusrive git@github.com:djcf/powerdns-docker.git` instead of the normal `git clone`.
2. Just edit the dns-inventory.yml file so it reflects your desired infrastructure. It's advised to use ns0. as the PDNS master, and ns1-4 and slaves.
3. Edit pdns-api.yml and seed it with desired random values.
4. Then run `ansible-playbook -i dns-inventory.yml ansible-install.yml`

Finished!

### Using docker-compose
If you don't want to use ansible, you can run the containers one at a time. This is how you would do it if you don't want the full auto-deployed infrastructure with slaves. So after cloning the repository, edit docker-compose.yml and make sure it has the desired values for API key etc. Then run `docker-compose up -d`.

**You can also deploy slaves the same way.** Just run `docker-compose -f docker-compose-slave.yml up -d` instead.

### Using docker

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

## TODO

Only need to test it now...