# Backup Scripts
A collection of scripts and other misc items related to `computerobandolero` server.

## How to Build
In each `rust/` subdir, run:
```shell
cargo build --release
```

## Deployments
Cron jobs are defined here `/var/spool/cron/crontabs/root` as:

    ```00 01 * * * /usr/src/backup-scripts/scripts/backup-mail.sh >> /var/log/backup-scripts/backup-mail.log 2>&1```
    ```05 01 * * * /usr/src/backup-scripts/rust/dns_checker/target/release/dns_checker >> /var/log/backup-scripts/dns_checker.log 2>&1```
    ```30 01 * * * /usr/src/backup-scripts/scripts/backup-web-logs.sh >> /var/log/backup-scripts/backup-web-logs.log 2>&1```
    ```00 02 * * * /usr/src/backup-scripts/scripts/update-web-analytics.sh >> /var/log/backup-scripts/update-web-analytics.log 2>&1```
    ```00 00 1 * * /usr/src/backup-scripts/scripts/update-geo-ip.sh >> /var/log/backup-scripts/update-geo-ip.log 2>&1```

Required env variables. MUST be defined in `/etc/environment` for cron to work correctly:
1. `TELEGRAM_MICHELED_EMERGENCIES_API_KEY`
1. `TELEGRAM_MICHELED_EMERGENCIES_CHAT_ID`
1. `TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY`
1. `TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID`
1. `TELEGRAM_MICHELED_BDAYS_API_KEY`
1. `TELEGRAM_MICHELED_BDAYS_CHAT_ID`

In addition, program-specific vars are:

- dns_checker
    1. `DNS_CHECKER_DOMAINS` a comma-separated list of domains to check DNS for.
    
- bdays_reminder
    1. `BDAY_REMINDER_PEOPLE` a comma-separated list of people and Birthdays dates like: `marco#1986-11-30`.
    
- backup-mail
    1. `BACKUP_MAIL_DESTINATION_PORT`
    1. `BACKUP_MAIL_IDENTITY_LOCATION`
    1. `BACKUP_MAIL_DESTINATION_IP`
    
- backup-web-logs
    1. `BACKUP_WEB_LOGS_DESTINATION_PORT`
    1. `BACKUP_WEB_LOGS_IDENTITY_LOCATION`
    1. `BACKUP_WEB_LOGS_DESTINATION_IP`

## Alert Chats
All messages must be in the form of
`{HOST_NAME}::{PROGRAM_NAME}[::{MESSAGE_TYPE}] "message"`
1. `{HOST_NAME}` = Human-readable name of the machine running the program.
1. `{PROGRAM_NAME}` = Name of the program. Must follow the program name conventions.
1. `{MESSAGE_TYPE}` = Optional. Applies to programs that send more than 1 type of message.
1. `"message"` = The message. Must be enclosed in double quotes.

### Emergencies
- chat: micheled_emergencies
- bot: micheled_emergencies_bot
- `TELEGRAM_MICHELED_EMERGENCIES_API_KEY`
- `TELEGRAM_MICHELED_EMERGENCIES_CHAT_ID`
- format: `HOSTNAME::DNS_CHECKER::EMERGENCY "message"`

E.g:
```
win10::DNS_CHECKER::EMERGENCY "NoRecordsFound { query: Query { name: Name { is_fqdn: false, labels: [micheledurante] },
 query_type: AAAA, query_class: IN }, valid_until: None }"
```

### Alive Messages
- chat: micheled_alive_messages
- bot: micheled_alive_messages_bot
- `TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY`
- `TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID`
- format: `HOSTNAME::DNS_CHECKER::ALIVE_MESSAGE "message"`

E.g.:
```
win10::DNS_CHECKER::ALIVE_MESSAGE "Ok"
```

### Bdays
- chat: micheled_bdays
- bot: micheled_bdays_bot
- `TELEGRAM_MICHELED_BDAYS_API_KEY`
- `TELEGRAM_MICHELED_BDAYS_CHAT_ID`
- format: `HOSTNAME::BDAYS "message"`

E.g.:
```
win10::BDAYS "Bday for Marco tomorrow"
win10::BDAYS "Bday for Marco today!"
```
