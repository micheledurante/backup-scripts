# Scripts-pluto
A collection of scripts and other misc items related to the Pluto box. 

## Deployments
`monthly-cleanup.sh` is located at `/opt/scripts-pluto`
The script is defined `/var/spool/cron/crontabs/root` as:

`00 01 * * * /opt/scripts-pluto/scripts/backup-mail.sh`

##Telegram Bots
Follow instructions here https://blog.bj13.us/2016/09/06/how-to-send-yourself-a-telegram-message-from-bash.html.

###Pluto Monitoring
- Bot name: `micheled_pluto`
- Bot user name: `micheled_pluto_bot`

## Current 1.0.0

## Upcoming 1.1.0
- Configure https://lib.rs/crates/check-if-email-exists and add a monitor for mail availability.
