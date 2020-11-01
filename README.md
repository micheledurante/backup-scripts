# Scripts-pluto
A collection of scripts and other misc items related to the Pluto box. 

## Alert Chats Specs
All messages must be in the form of
`{HOST_NAME}::{PROGRAM_NAME}::{MESSAGE_TYPE} "{message}"`

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
2. `dns_checker` is located at `/opt/scripts-pluto/rust/dns_checker/target/release/dns_checker`

Cron jobs are defined here `/var/spool/cron/crontabs/root` as:

    ```00 01 * * * /opt/scripts-pluto/scripts/backup-mail.sh```
    ```01 01 * * * /opt/scripts-pluto/rust/dns_checker/target/release/dns_checker```

Required env variables:
1. `DNS_CHECKER_DOMAINS` must contain a comma-separated list of domains to check DNS for.
