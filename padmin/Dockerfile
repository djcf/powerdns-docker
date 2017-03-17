FROM python:2-alpine
MAINTAINER Dimitris Zervas <dzervas@dzervas.gr>

ADD https://gist.githubusercontent.com/djcf/bcd2f725652f46b4786e29ffdc32495c/raw /usr/local/bin/minify.sh

RUN apk add --update sudo build-base git libffi-dev openldap-dev python-dev && \
	git clone https://github.com/ngoduykhanh/PowerDNS-Admin /src && \
	cd /src && pip install -r requirements.txt && \
	chmod +x /usr/local/bin/minify.sh && /usr/local/bin/minify.sh

COPY config.py /src/
COPY create_admin.py /src/
COPY start.sh /start.sh

EXPOSE 8080
VOLUME [ "/data" ]
WORKDIR /src

CMD [ "/start.sh" ]