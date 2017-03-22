#!/bin/bash

# See https://blog.powerdns.com/2016/02/02/powerdns-authoritative-the-new-old-way-to-manage-domains/

docker run -v powerdns_database:/etc/powerdns/sqlite3 --rm -it powerdns pdnsutil