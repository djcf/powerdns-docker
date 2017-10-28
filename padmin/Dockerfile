FROM python:2-alpine
MAINTAINER Dimitris Zervas <dzervas@dzervas.gr>

ADD https://gist.githubusercontent.com/djcf/bcd2f725652f46b4786e29ffdc32495c/raw /usr/local/bin/minify.sh

RUN apk add --update sudo build-base git libffi-dev openldap-dev python-dev && \
	git clone https://github.com/ngoduykhanh/PowerDNS-Admin /src && \
	cd /src && pip install -r requirements.txt && \
	touch /data/padmin.sqlite && \
	chown nobody /data/padmin.sqlite && \
	python /src/create_db.py && \
	chmod +x /usr/local/bin/minify.sh && /usr/local/bin/minify.sh && \
	mkdir -p /data/uploads && \
	chown -R nobody /data

COPY config.py /src/
COPY create_admin.py /src/
COPY start.sh /start.sh

EXPOSE 8080
VOLUME [ "/data" ]
WORKDIR /src

USER nobody

CMD [ "/start.sh" ]