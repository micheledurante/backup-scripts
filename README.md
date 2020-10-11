# Scripts-pluto
A collection of scripts and other misc items related to the Pluto box. 

## Deployments
1. `monthly-cleanup.sh` is located at `/opt/scripts-pluto`
2. `dns_checker` is located at `...`

Cron jobs are defined here `/var/spool/cron/crontabs/root` as:

    ```00 01 * * * /opt/scripts-pluto/scripts/backup-mail.sh```

Required env variables:
1. `TELEGRAM_MICHELED_PLUTO_API_KEY`: dns_checker
1. `TELEGRAM_MICHELED_PLUTO_CHAT_ID`: dns_checker

##Telegram Bots
Follow instructions here https://blog.bj13.us/2016/09/06/how-to-send-yourself-a-telegram-message-from-bash.html.

###Pluto Monitoring
- Bot name: `micheled_pluto`: dns_checker
- Bot user name: `micheled_pluto_bot`: dns_checker

Example URL
```bash
curl -s "https://api.telegram.org/bot{TELEGRAM_MICHELED_PLUTO_API_KEY}/sendMessage?chat_id={TELEGRAM_MICHELED_PLUTO_CHAT_ID}&text=pingping"
```

##Releases

### Current 1.0.0

### Upcoming 1.1.0
- Configure https://lib.rs/crates/check-if-email-exists and add a monitor for mail availability.
