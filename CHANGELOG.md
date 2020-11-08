# Changelog

## 1.1.0 [Upcoming]
- Configure https://lib.rs/crates/check-if-email-exists and add a monitor for mail availability.

## 1.0.2 [2020-11-08]
#### Added
- Use `consts` and `env` for chat IDs ad messages to use the new `EMRGENCIES` and `ALIVE_MESSAGES` chats.
- Monitor `bcrypt-decoder.com`.

## 1.0.1 [2020-11-01]
#### Added
- Format Telegram messages according to the standard defined in `README.md`.
- Add alive messages after mail backup.
- Provide monitor program for domain DNS availability. Currently, monitored: 
    - `annikaschall.com` 
    - `micheledurante.co.uk`
    - `micheledurante.com`

## 1.0.0 [2020-01-01]
#### Added
- Create backup script to download the `/var/mail` tarballs.
