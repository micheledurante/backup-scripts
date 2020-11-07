#!/bin/sh
# Script to backup the web server logs.
# See README for more info.

YEAR=$(date +%Y)
HOSTNAME=$(hostname)
# Backup web logs ssh vars
IDENTITY_LOCATION=$(BACKUP_WEB_LOGS_IDENTITY_LOCATION)
DESTINATION_IP=$(BACKUP_WEB_LOGS_DESTINATION_IP)
DESTINATION_PORT=$(BACKUP_WEB_LOGS_DESTINATION_PORT)
# Monitoring vars
TELEGRAM_API_KEY=$(TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY)
TELEGRAM_CHAT_ID=$(TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID)

# BcryptDecoder
rsync -chazP --no-motd --rsh="ssh -p ${DESTINATION_PORT} -i ${IDENTITY_LOCATION}" scripts-pluto@${DESTINATION_IP}:/var/log/nginx/bcrypt_decoder/bcrypt-decoder.com.access.log "/mnt/raid/backups/debianbox.web/bcrypt-decoder.com.${YEAR}.access.log"

# Fosdinuovo
rsync -chazP --no-motd --rsh="ssh -p ${DESTINATION_PORT} -i ${IDENTITY_LOCATION}" scripts-pluto@${DESTINATION_IP}:/var/log/nginx/bcrypt_decoder/bcrypt-decoder.com.access.log "/mnt/raid/backups/debianbox.web/fosdinuovo.org.${YEAR}.access.log"

# This is Durante
rsync -chazP --no-motd --rsh="ssh -p ${DESTINATION_PORT} -i ${IDENTITY_LOCATION}" scripts-pluto@${DESTINATION_IP}:/var/log/nginx/bcrypt_decoder/bcrypt-decoder.com.access.log "/mnt/raid/backups/debianbox.web/this-is-durante.com.${YEAR}.access.log"

# Error logs
rsync -chazP --no-motd --rsh="ssh -p ${DESTINATION_PORT} -i ${IDENTITY_LOCATION}" scripts-pluto@${DESTINATION_IP}:/var/log/nginx/error.log "/mnt/raid/backups/debianbox.web/error.log"

# Log to custom file
logger -s "Web logs for \"${YEAR}\" backed up" 2>> /var/log/scripts-pluto/backup-web-logs.log

# Send Telegram message
curl -s "https://api.telegram.org/bot${TELEGRAM_API_KEY}/sendMessage?chat_id=${TELEGRAM_CHAT_ID}&parse_mode=HTML&text=<code>${HOSTNAME}::ALIVE_MESSAGE::BACKUP_WEB_LOGS \"Ok\"</code>"

exit 0
