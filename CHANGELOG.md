# Changelog

## 1.1.0 (Upcoming)
- Configure https://lib.rs/crates/check-if-email-exists and add a monitor for mail availability.

## 1.0.1
- Use `consts` and `env` for chat IDs and messages to use the new `EMRGENCIES` and `ALIVE_MESSAGES` chats.
- Format Telegram messages according to the standard defined in `README.md`.
- Add alive messages after mail backup.

## 1.0.0
- Provide monitor program for domain DNS availability. Currently, monitored: 
    - `annikaschall.com` 
    - `micheledurante.co.uk`
    - `micheledurante.com`
- Provide the bash script to download and store locally the daily email tarball.
