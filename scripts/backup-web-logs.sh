#!/bin/sh
# Script to backup the web server logs.
# See README for more info.

YEAR=$(date +%Y)
HOSTNAME=$(hostname)

# BcryptDecoder
rsync -chazP --no-motd --rsh="ssh -p ${BACKUP_WEB_LOGS_DESTINATION_PORT} -i ${BACKUP_WEB_LOGS_IDENTITY_LOCATION}" scripts-pluto@${BACKUP_WEB_LOGS_DESTINATION_IP}:/var/log/nginx/bcrypt_decoder/bcrypt-decoder.com.access.log "/mnt/raid/backups/debianbox.web/bcrypt-decoder.com.${YEAR}.access.log"

# Fosdinuovo
rsync -chazP --no-motd --rsh="ssh -p ${BACKUP_WEB_LOGS_DESTINATION_PORT} -i ${BACKUP_WEB_LOGS_IDENTITY_LOCATION}" scripts-pluto@${BACKUP_WEB_LOGS_DESTINATION_IP}:/var/log/nginx/fosdinuovo/fosdinuovo.org.access.log "/mnt/raid/backups/debianbox.web/fosdinuovo.org.${YEAR}.access.log"

# This is Durante
rsync -chazP --no-motd --rsh="ssh -p ${BACKUP_WEB_LOGS_DESTINATION_PORT} -i ${BACKUP_WEB_LOGS_IDENTITY_LOCATION}" scripts-pluto@${BACKUP_WEB_LOGS_DESTINATION_IP}:/var/log/nginx/this-is-durante/this-is-durante.com.access.log "/mnt/raid/backups/debianbox.web/this-is-durante.com.${YEAR}.access.log"

# Error logs
rsync -chazP --no-motd --rsh="ssh -p ${BACKUP_WEB_LOGS_DESTINATION_PORT} -i ${BACKUP_WEB_LOGS_IDENTITY_LOCATION}" scripts-pluto@${BACKUP_WEB_LOGS_DESTINATION_IP}:/var/log/nginx/error.log "/mnt/raid/backups/debianbox.web/error.log"

chown -R nobody:nogroup /mnt/raid/backups/debianbox.web

# Log to custom file
logger -s "Web logs for \"${YEAR}\" back up Ok" 2>> /var/log/scripts-pluto/backup-web-logs.log

# Send Telegram message
curl -s "https://api.telegram.org/bot${TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY}/sendMessage?chat_id=${TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID}&parse_mode=HTML&text=<code>${HOSTNAME}::ALIVE_MESSAGE::BACKUP_WEB_LOGS \"Ok\"</code>"

exit 0
