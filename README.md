# Scripts-pluto
A collection of scripts and other misc items related to the Pluto box. 

## Alert Chats Specs
All messages must be in the form of
`{SERVER_NAME}_{MONITOR_NAME} {messages}`

### Emergencies
- chat: micheled_emergencies
- bot: micheled_emergencies_bot
- `TELEGRAM_MICHELED_EMERGENCIES_CHAT_ID`
- format: `"HOSTNAME::DNS_CHECKER::EMERGENCY_PREFIX {message}"`

E.g:
```
win10::EMERGENCY::DNS_CHECKER NoRecordsFound { query: Query { name: Name { is_fqdn: false, labels: [micheledurante] },
 query_type: AAAA, query_class: IN }, valid_until: None }
```

### Alive Messages
- chat: micheled_alive_messages
- bot: micheled_alive_messages_bot
- `TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID`
- format: `"HOSTNAME::DNS_CHECKER::ALIVE_MESSAGE_PREFIX {message}"`

E.g.:
```
win10::ALIVE_MESSAGE::DNS_CHECKER "All checks done."
```

Generally:
- `EMERGENCY_PREFIX` = `EMERGENCY`
- `ALIVE_MESSAGE_PREFIX` = `ALIVE_MESSAGE`

## Deployments
1. `monthly-cleanup.sh` is located at `/opt/scripts-pluto`
2. `dns_checker` is located at `...`

Cron jobs are defined here `/var/spool/cron/crontabs/root` as:

    ```00 01 * * * /opt/scripts-pluto/scripts/backup-mail.sh```

Required env variables:
1. `DNS_CHECKER_DOMAINS` must contain a comma-separated list of domains to check DNS for.

## Telegram Bots
Follow instructions here https://blog.bj13.us/2016/09/06/how-to-send-yourself-a-telegram-message-from-bash.html.

### Pluto Monitoring
- Bot name: `micheled_pluto`: dns_checker
- Bot user name: `micheled_pluto_bot`: dns_checker

Example URL
```bash
curl -s "https://api.telegram.org/bot{TELEGRAM_MICHELED_PLUTO_API_KEY}/sendMessage?chat_id={TELEGRAM_MICHELED_PLUTO_CHAT_ID}&text=pingping"
```
