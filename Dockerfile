FROM python:2.7.18-alpine
WORKDIR /
RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers zlib-dev jpeg-dev \
  && python -m pip install dumb-init Pillow --no-cache-dir \
  && apk del .tmp \
  && apk add --no-cache libjpeg git openssl \
  && git clone --depth 1 --branch V0.7.4 https://github.com/iBaa/PlexConnect.git

EXPOSE 53 80 443

ENV PLEXCONNECT_ENABLE_PLEXGDM=True \
  PLEXCONNECT_IP_PMS=192.168.178.10 \
  PLEXCONNECT_PORT_PMS=32400 \
  PLEXCONNECT_ENABLE_DNSSERVER=True \
  PLEXCONNECT_PORT_DNSSERVER=53 \
  PLEXCONNECT_IP_DNSMASTER=8.8.8.8 \
  PLEXCONNECT_PREVENT_ATV_UPDATE=True \
  PLEXCONNECT_INTERCEPT_ATV_ICON=True \
  PLEXCONNECT_ENABLE_PLEXCONNECT_AUTODETECT=True \
  PLEXCONNECT_IP_PLEXCONNECT=0.0.0.0 \
  PLEXCONNECT_USE_CUSTOM_DNS_BIND_IP=False \
  PLEXCONNECT_CUSTOM_DNS_BIND_IP=0.0.0.0 \
  PLEXCONNECT_HOSTTOINTERCEPT=trailers.apple.com \
  PLEXCONNECT_ICON=movie-trailers \
  PLEXCONNECT_CERTFILE=./assets/certificates/trailers.pem \
  PLEXCONNECT_PORT_WEBSERVER=80 \
  PLEXCONNECT_ENABLE_WEBSERVER_SSL=True \
  PLEXCONNECT_PORT_SSL=443 \
  PLEXCONNECT_ALLOW_GZIP_ATV=False \
  PLEXCONNECT_ALLOW_GZIP_PMSLOCAL=False \
  PLEXCONNECT_ALLOW_GZIP_PMSREMOTE=True \
  PLEXCONNECT_FANART_QUALITY=High \
  PLEXCONNECT_LOGLEVEL=Normal \
  PLEXCONNECT_LOGPATH=.

COPY init.sh /usr/local/bin/

ENTRYPOINT ["dumb-init"]
CMD [ "init.sh" ]