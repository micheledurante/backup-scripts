#!/bin/sh
# Script to backup the mail tarball. Designed to be run as a cron job at 01:00 every day and as root. E.g.:
# 00 01 * * * /opt/scripts-pluto/scripts/backup-mail.sh

DATE=$(date --rfc-3339=date)

sshpass -f '/root/.tarball-mail' scp -P 2020 tarball-mail@207.154.197.85:/home/tarball-mail/${DATE}.mail.tar.gz /mnt/raid/backups/mail

chown nobody:nogroup /mnt/raid/backups/mail/${DATE}.mail.tar.gz
