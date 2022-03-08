#!/bin/sh
# Script to backup the web server logs.

YEAR=$(date +%Y)
YEAR_MONTH=$(date +%Y-%m)
HOSTNAME=$(hostname)

# BcryptDecoder
rsync -chazP --no-motd --rsh="ssh -p ${BACKUP_WEB_LOGS_DESTINATION_PORT} -i ${BACKUP_WEB_LOGS_IDENTITY_LOCATION}" scripts-pluto@"${BACKUP_WEB_LOGS_DESTINATION_IP}:/var/log/nginx/bcrypt_decoder/bcrypt-decoder.com.access.log" "/mnt/raid/backups/debianbox.web/bcrypt-decoder.com.${YEAR_MONTH}.access.log";

# Fosdinuovo
rsync -chazP --no-motd --rsh="ssh -p ${BACKUP_WEB_LOGS_DESTINATION_PORT} -i ${BACKUP_WEB_LOGS_IDENTITY_LOCATION}" scripts-pluto@"${BACKUP_WEB_LOGS_DESTINATION_IP}:/var/log/nginx/fosdinuovo/fosdinuovo.org.access.log" "/mnt/raid/backups/debianbox.web/fosdinuovo.org.${YEAR_MONTH}.access.log";

# This is Durante
rsync -chazP --no-motd --rsh="ssh -p ${BACKUP_WEB_LOGS_DESTINATION_PORT} -i ${BACKUP_WEB_LOGS_IDENTITY_LOCATION}" scripts-pluto@"${BACKUP_WEB_LOGS_DESTINATION_IP}:/var/log/nginx/this-is-durante/thisisdurante.com.access.log" "/mnt/raid/backups/debianbox.web/this-is-durante.com.${YEAR_MONTH}.access.log";

# BcryptDecoder
goaccess \
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
goaccess \
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
goaccess \
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

# Send Telegram message
curl -s "https://api.telegram.org/bot${TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY}/sendMessage?chat_id=${TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID}&parse_mode=HTML&text=<code>${HOSTNAME}::ALIVE_MESSAGE::BACKUP_WEB_LOGS \"Ok\"</code>";

exit 0
