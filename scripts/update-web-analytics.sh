#!/bin/sh
# Script to update the goaccess databases and to update HTML reports.

YEAR=$(date +%Y)
YEAR_MONTH=$(date +%Y-%m)
HOSTNAME=$(hostname)

# BcryptDecoder
/usr/local/bin/goaccess \
    --agent-list \
    --anonymize-ip \
    --persist \
    --real-os \
    --restore \
    --html-prefs='{"theme":"bright","perPage":10,"layout":"vertical","showTables":true}' \
    --geoip-database "/usr/share/GeoIP/GeoLite2-City.mmdb" \
    --db-path "/mnt/raid/diy/bcrypt-decoder/analytics/db/" \
    --log-format "COMBINED" \
    --output "/mnt/raid/diy/bcrypt-decoder/analytics/bcrypt_decoder.com.${YEAR}.html" \
    "/mnt/raid/backups/debianbox.web/bcrypt-decoder.com.${YEAR_MONTH}.access.log";

# Fosdinuovo
/usr/local/bin/goaccess \
    --agent-list \
    --anonymize-ip \
    --persist \
    --real-os \
    --restore \
    --html-prefs='{"theme":"bright","perPage":10,"layout":"vertical","showTables":true}' \
    --geoip-database "/usr/share/GeoIP/GeoLite2-City.mmdb" \
    --db-path "/mnt/raid/diy/fosdinuovo/analytics/db/" \
    --log-format "COMBINED" \
    --output "/mnt/raid/diy/fosdinuovo/analytics/fosdinuovo.org.${YEAR}.html" \
    "/mnt/raid/backups/debianbox.web/fosdinuovo.org.${YEAR_MONTH}.access.log";

# This is Durante
/usr/local/bin/goaccess \
    --agent-list \
    --anonymize-ip \
    --persist \
    --real-os \
    --restore \
    --html-prefs='{"theme":"bright","perPage":10,"layout":"vertical","showTables":true}' \
    --geoip-database "/usr/share/GeoIP/GeoLite2-City.mmdb" \
    --db-path "/mnt/raid/diy/this-is-durante/analytics/db/" \
    --log-format "COMBINED" \
    --output "/mnt/raid/diy/this-is-durante/analytics/this-is-durante.com.${YEAR}.html" \
    "/mnt/raid/backups/debianbox.web/this-is-durante.com.${YEAR_MONTH}.access.log";

chown -R nobody:nogroup \
  /mnt/raid/diy/bcrypt-decoder/analytics \
  /mnt/raid/diy/this-is-durante/analytics \
  /mnt/raid/diy/fosdinuovo/analytics;

# Send Telegram message
curl -s "https://api.telegram.org/bot${TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY}/sendMessage?chat_id=${TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID}&parse_mode=HTML&text=<code>${HOSTNAME}::ALIVE_MESSAGE::UPDATE_WEB_ANALYTICS \"Ok\"</code>";

exit 0
