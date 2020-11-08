# Scripts-pluto
A collection of scripts and other misc items related to `thecave.pluto` server.

## thecave.pluto Deployments
Cron jobs are defined here `/var/spool/cron/crontabs/root` as:

    ```00 01 * * * /usr/src/scripts-pluto/scripts/backup-mail.sh >> /var/log/scripts-pluto/backup-mail.log 2>&1```
    ```05 01 * * * /usr/src/scripts-pluto/rust/dns_checker/target/release/dns_checker >> /var/log/scripts-pluto/dns_checker.log 2>&1```
    ```30 01 * * * /usr/src/scripts-pluto/scripts/backup-web-logs.sh >> /var/log/scripts-pluto/backup-web-logs.log 2>&1```

Required env variables. MUST be defined in `/etc/environment` for cron to work correctly:
- dns_checker
    1. `DNS_CHECKER_DOMAINS` a comma-separated list of domains to check DNS for.
    1. `TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY`
    1. `TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID`
    1. `TELEGRAM_MICHELED_EMERGENCIES_API_KEY`
    1. `TELEGRAM_MICHELED_EMERGENCIES_CHAT_ID`
    
- backup-mail
    1. `BACKUP_MAIL_DESTINATION_PORT`
    1. `BACKUP_MAIL_IDENTITY_LOCATION`
    1. `BACKUP_MAIL_DESTINATION_IP`
    1. `TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY`
    1. `TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID`
    
- backup-web-logs
    1. `BACKUP_WEB_LOGS_DESTINATION_PORT`
    1. `BACKUP_WEB_LOGS_IDENTITY_LOCATION`
    1. `BACKUP_WEB_LOGS_DESTINATION_IP`
    1. `TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY`
    1. `TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID`

## Alert Chats Specs
All messages must be in the form of
`{HOST_NAME}::{PROGRAM_NAME}::{MESSAGE_TYPE} "message"`

### Emergencies
- chat: micheled_emergencies
- bot: micheled_emergencies_bot
- `TELEGRAM_MICHELED_EMERGENCIES_CHAT_ID`
- format: `HOSTNAME::DNS_CHECKER::EMERGENCY "message"`

E.g:
```
win10::EMERGENCY::DNS_CHECKER "NoRecordsFound { query: Query { name: Name { is_fqdn: false, labels: [micheledurante] },
 query_type: AAAA, query_class: IN }, valid_until: None }"
```

### Alive Messages
- chat: micheled_alive_messages
- bot: micheled_alive_messages_bot
- `TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID`
- format: `HOSTNAME::DNS_CHECKER::ALIVE_MESSAGE "message"`

E.g.:
```
win10::ALIVE_MESSAGE::DNS_CHECKER "Ok"
```
