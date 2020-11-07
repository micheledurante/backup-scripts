#!/bin/sh
# Script to backup the mail tarball.
# See README for more info.

DATE=$(date --rfc-3339=date)
MONTH=$(date +%Y-%m)
HOSTNAME=$(hostname)
# Backup mail ssh vars
IDENTITY_LOCATION=$(BACKUP_MAIL_IDENTITY_LOCATION)
DESTINATION_IP=$(BACKUP_MAIL_DESTINATION_IP)
DESTINATION_PORT=$(BACKUP_MAIL_DESTINATION_PORT)
# Monitoring vars
TELEGRAM_API_KEY=$(TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY)
TELEGRAM_CHAT_ID=$(TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID)

#sshpass -f '/root/.tarball-mail' scp -P ${DESTINATION_PORT} tarball-mail@${DESTINATION_IP}/home/tarball-mail/${MONTH}.mail.tar.gz /mnt/raid/backups/mail

rsync -chazP --no-motd --rsh="ssh -p ${DESTINATION_PORT} -i ${IDENTITY_LOCATION}" tarball-mail@${DESTINATION_IP}:/home/tarball-mail/${DATE}.mail.tar.gz "/mnt/raid/backups/mail/${MONTH}.mail.tar.gz"

chown nobody:nogroup /mnt/raid/backups/mail/${MONTH}.mail.tar.gz

# Log to custom file
logger -s "Tarball \"${MONTH}.mail.tar.gz\" backed up in \"/mnt/raid/backups/mail\"" 2>> /var/log/scripts-pluto/backup-mail.log

# Send Telegram message
curl -s "https://api.telegram.org/bot${TELEGRAM_API_KEY}/sendMessage?chat_id=${TELEGRAM_CHAT_ID}&parse_mode=HTML&text=<code>${HOSTNAME}::ALIVE_MESSAGE::BACKUP_MAIL \"Ok\"</code>"

exit 0
