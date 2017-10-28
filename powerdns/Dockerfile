FROM alpine:latest
MAINTAINER daniel

RUN apk add --update pdns pdns-backend-sqlite3 sqlite libldap pdns-backend-ldap openldap-dev strace

ADD https://raw.githubusercontent.com/PowerDNS/pdns/master/modules/gsqlite3backend/schema.sqlite3.sql /etc/pdns/create_db.sql
ADD https://gist.githubusercontent.com/djcf/bcd2f725652f46b4786e29ffdc32495c/raw /usr/local/bin/minify.sh

RUN mkdir -p /etc/pdns/run/sqlite3 && \
	touch /etc/pdns/run/sqlite3/zone_db.sqlite && \
	sqlite3 /etc/pdns/run/sqlite3/zone_db.sqlite < /etc/pdns/create_db.sql && \
	chmod +x /usr/local/bin/minify.sh && /usr/local/bin/minify.sh

COPY *.conf /etc/pdns/
COPY start.sh /usr/local/bin/start.sh

RUN chown -R pdns:pdns /etc/pdns/

EXPOSE 5353
EXPOSE 5353/udp
EXPOSE 8080

USER pdns

WORKDIR /etc/pdns
VOLUME [ "/etc/pdns/run/sqlite3/" ]
CMD ["/usr/local/bin/start.sh"]