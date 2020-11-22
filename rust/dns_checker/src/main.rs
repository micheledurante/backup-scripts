mod consts;
use crate::consts::*;
use std::env;
use trust_dns_resolver::Resolver;
use ureq;
use ureq::Error;

/// Send a message to the requested bot.
pub fn send_telegram_message(text: String, api_key: String, chat_id: String) {
    ureq::post(&format!(
        "https://api.telegram.org/bot{api_key}/sendMessage?chat_id={chat_id}&parse_mode=HTML&text=<code>{text}</code>",
        api_key = api_key,
        chat_id = chat_id,
        text = text
    )).call();
}

/// Do DNS lookups for the given domains. Send a Telegram messages to emergencies in case of error.
fn validate_domains(domains: Vec<&str>) {
    let resolver = Resolver::from_system_conf().unwrap();

    for domain in &domains {
        let resolve_result = resolver.lookup_ip(domain);

        if resolver.lookup_ip(domain).is_err() {
            send_telegram_message(
                format!(
                    "{}::EMERGENCY::{} {:?}",
                    hostname::get().unwrap().into_string().unwrap(),
                    DNS_CHECKER_PROGRAM_NAME,
                    resolve_result.unwrap_err().kind()
                ),
                env::var(TELEGRAM_MICHELED_EMERGENCIES_API_KEY).unwrap(),
                env::var(TELEGRAM_MICHELED_EMERGENCIES_CHAT_ID).unwrap(),
            );
        }
    }
}

/**
 * By default, Rust variables are passed by "copy" or "move" (depends on type). Remember to
 * expressly use ref in function declarations!!!
 *
 * https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html
 */
fn main() -> Result<(), Error> {
    let domains_var = env::var(DNS_CHECKER_DOMAINS).unwrap();
    let domains = domains_var.split(",").collect();

    validate_domains(domains);

    Ok(send_telegram_message(
        format!(
            "{}::ALIVE_MESSAGE::{} {:?}",
            hostname::get().unwrap().into_string().unwrap(),
            DNS_CHECKER_PROGRAM_NAME,
            "Ok"
        ),
        env::var(TELEGRAM_MICHELED_ALIVE_MESSAGES_API_KEY).unwrap(),
        env::var(TELEGRAM_MICHELED_ALIVE_MESSAGES_CHAT_ID).unwrap(),
    ))
}

#[cfg(test)]
mod tests {
    // Look at tests again as soon as mocking external structs will be possible without creating
    // traits to mimic the behaviour during tests.
    //
    // https://docs.rs/mockall/0.6.0/mockall/#external-traits
}
