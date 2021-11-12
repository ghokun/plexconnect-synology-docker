#!/bin/sh

# Create ssl certificate if needed
if [ ! -f "/PlexConnect/assets/certificates/trailers.pem" ]; then
  cd /PlexConnect/assets/certificates || exit 1
  openssl req -new -nodes -newkey rsa:4096 -out trailers.pem -keyout trailers.key -x509 -days 3650 -subj "/C=US/CN=trailers.apple.com"
  openssl x509 -in trailers.pem -outform der -out trailers.cer && cat trailers.key >> trailers.pem
  cd "/" || exit 1
else
  echo "Certificate already exists"
fi

# Create Settings.cfg from ENV vars
if [ ! -f "/PlexConnect/Settings.cfg" ]; then
  echo "[PlexConnect]" > /PlexConnect/Settings.cfg
  env | grep '^PLEXCONNECT_' | sed -E -e 's/^PLEXCONNECT_//' -e 's/(.*)=/\1 /' | awk '{printf "%s", tolower($1); $1=""; print " =" $0}' >> /PlexConnect/Settings.cfg
else
  echo "Settings.cfg already exists"
fi

python /PlexConnect/PlexConnect.py