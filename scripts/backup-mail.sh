#!/bin/sh
# Script to backup the mail tarball.
# See README for more info.

DATE=$(date --rfc-3339=date)
YEAR_MONTH=$(date +%Y-%m)
HOSTNAME=$(hostname)

rsync -chazP --no-motd --rsh="ssh -p ${BACKUP_MAIL_DESTINATION_PORT} -i ${BACKUP_MAIL_IDENTITY_LOCATION}" tarball-mail@${BACKUP_MAIL_DESTINATION_IP}:/home/tarball-mail/${DATE}.mail.tar.gz "/mnt/raid/backups/mail/${YEAR_MONTH}.mail.tar.gz";

chown nobody:nogroup /mnt/raid/backups/mail/${YEAR_MONTH}.mail.tar.gz;

# Send Telegram message
curl -s "https://api.telegram.org/bot${TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY}/sendMessage?chat_id=${TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID}&parse_mode=HTML&text=<code>${HOSTNAME}::ALIVE_MESSAGE::BACKUP_MAIL \"Ok\"</code>";

exit 0
