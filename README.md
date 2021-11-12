# Run Plexconnect on Synology using Docker

- Tested on Synology DSM7.0 using DS1520+

```bash
docker run -d --name plexconnect \
  -p 53:53/udp \ # Remove if you are using external DNS
  -p 80:80 \
  -p 443:443 \
  # Modify following environment variables according to your needs
  -e PLEXCONNECT_ENABLE_PLEXGDM=True \
  -e PLEXCONNECT_IP_PMS=192.168.178.10 \
  -e PLEXCONNECT_PORT_PMS=32400 \
  -e PLEXCONNECT_ENABLE_DNSSERVER=True \
  -e PLEXCONNECT_PORT_DNSSERVER=53 \
  -e PLEXCONNECT_IP_DNSMASTER=8.8.8.8 \
  -e PLEXCONNECT_PREVENT_ATV_UPDATE=True \
  -e PLEXCONNECT_INTERCEPT_ATV_ICON=True \
  -e PLEXCONNECT_ENABLE_PLEXCONNECT_AUTODETECT=True \
  -e PLEXCONNECT_IP_PLEXCONNECT=0.0.0.0 \
  -e PLEXCONNECT_USE_CUSTOM_DNS_BIND_IP=False \
  -e PLEXCONNECT_CUSTOM_DNS_BIND_IP=0.0.0.0 \
  -e PLEXCONNECT_HOSTTOINTERCEPT=trailers.apple.com \
  -e PLEXCONNECT_ICON=movie-trailers \
  -e PLEXCONNECT_CERTFILE=./assets/certificates/trailers.pem \
  -e PLEXCONNECT_PORT_WEBSERVER=80 \
  -e PLEXCONNECT_ENABLE_WEBSERVER_SSL=True \
  -e PLEXCONNECT_PORT_SSL=443 \
  -e PLEXCONNECT_ALLOW_GZIP_ATV=False \
  -e PLEXCONNECT_ALLOW_GZIP_PMSLOCAL=False \
  -e PLEXCONNECT_ALLOW_GZIP_PMSREMOTE=True \
  -e PLEXCONNECT_FANART_QUALITY=High \
  -e PLEXCONNECT_LOGLEVEL=Normal \
  -e PLEXCONNECT_LOGPATH=. \
  ghcr.io/ghokun/plexconnect-syngoloy-docker:0.7.4
```
