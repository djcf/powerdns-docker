FROM python:2-alpine
MAINTAINER Dimitris Zervas <dzervas@dzervas.gr>

ADD https://gist.githubusercontent.com/djcf/bcd2f725652f46b4786e29ffdc32495c/raw /usr/local/bin/minify.sh

RUN apk add --update build-base git libffi-dev openldap-dev python-dev && \
	git clone https://github.com/ngoduykhanh/PowerDNS-Admin /src && \
	cd /src && pip install -r requirements.txt && \
	mkdir -p /data/uploads && \
	touch /data/padmin.sqlite && \
	chown -R nobody:nobody /data && \
	chmod +x /usr/local/bin/minify.sh && /usr/local/bin/minify.sh

COPY *.py /src/
COPY start.sh /usr/local/bin/start.sh
COPY padmin.sqlite /data
RUN 	chown -R nobody:nobody /data

EXPOSE 8080
VOLUME [ "/data" ]
WORKDIR /src

#RUN python /src/create_db.py && mv /src/final-config.py /src/config.py
USER nobody

CMD [ "/usr/local/bin/start.sh" ]