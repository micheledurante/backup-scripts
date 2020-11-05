#!/bin/sh
# Script to backup the mail tarball. Designed to be run as a cron job at 01:00 every day and as root. E.g.:
# 00 01 * * * /opt/scripts-pluto/scripts/backup-mail.sh

DATE=$(date --rfc-3339=date)
HOSTNAME=$(hostname)

sshpass -f '/root/.tarball-mail' scp -P 2020 tarball-mail@207.154.197.85:/home/tarball-mail/${DATE}.mail.tar.gz /mnt/raid/backups/mail

chown nobody:nogroup /mnt/raid/backups/mail/${DATE}.mail.tar.gz

# Log to custom file.
logger -s "Tarball ${DATE}.mail.tar.gz backed up in /mnt/raid/backups/mail" 2>> /var/log/scripts-pluto/backup-mail.log

# Send Telegram message
curl -s "https://api.telegram.org/bot1219926400:AAEqdCwp0qgvUBjRn7BSNI4WaLcZQQXKMnc/sendMessage?chat_id=104361488&parse_mode=HTML&text=<code>${HOSTNAME}::ALIVE_MESSAGE::BACKUP_MAIL \"Backup done.\"</code>"

exit 0
