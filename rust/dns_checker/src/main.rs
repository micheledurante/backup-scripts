/**
 * By default, Rust variables are passed by "copy" or "move" (depends on type). Remember to
 * expressly use ref in function declarations!!!
 *
 * @see https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html
 */
use std::env;
use std::io::Error;
use trust_dns_resolver::Resolver;
use ureq;

/// Send a message to the defined BOT by the env vars.
pub fn send_telegram_message(text: String) {
    ureq::post(&format!(
        "https://api.telegram.org/bot{apiKey}/sendMessage?chat_id={chat_id}&parse_mode=HTML&text=<code>{text}</code>",
        apiKey = env::var("TELEGRAM_MICHELED_PLUTO_API_KEY").unwrap(),
        chat_id = env::var("TELEGRAM_MICHELED_PLUTO_CHAT_ID").unwrap(),
        text = text
    ))
    .call();
}

/// Perform a dns lookup for the given domain.
fn lookup_domain(resolver: &Resolver, domain: &str) {
    let resolve_result = resolver.lookup_ip(domain);

    if resolver.lookup_ip(domain).is_err() {
        send_telegram_message(format!("{:?}", resolve_result.unwrap_err().kind()));
    }
}

/// Given a list of domains, execute a DNS lookup.
fn validate_domains(domains: Vec<&str>) {
    let resolver = Resolver::from_system_conf().unwrap();

    for domain in &domains {
        lookup_domain(&resolver, domain)
    }
}

fn main() -> Result<(), Error> {
    let domains = vec![
        "annikaschall.com",
        "micheledurante.co.uk",
        "micheledurante.com",
    ];

    validate_domains(domains);
    Ok(send_telegram_message(String::from("DNS records ok")))
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;
    use mockall::predicate::*;
    use mockall::*;
    use trust_dns_resolver::error::ResolveResult;
    use trust_dns_resolver::lookup_ip::LookupIp;

    trait MyTrait {
        fn foo(&self, x: u32) -> u32;
    }

    #[test]
    fn my_test() {
        // let mut mock = MockMyTrait::new();
        mock! {
            MyTrait {}     // Name of the mock struct, less the "Mock" prefix
            trait Clone {   // definition of the trait to mock
                fn clone(&self) -> Self;
            }
        }

        let mut mock1 = MockMyStruct::new();
        let mut mock = MockMyStruct::new();
        let mut mock = mock.expect_foo().with(eq(4)).times(1).returning(|x| x + 1);
        assert_eq!(5, mock.foo(4));
    }

    // #[test]
    // fn test_lookup_domain_empty_string() {
    //     let mut mock = MockResolver::new();
    //     let domain = "invalid-domain";
    //
    //     mock.expect_lookup_ip()
    //         .with(eq(domain))
    //         .times(1)
    //         .returning(ResolveResult::Ok(()));
    //
    //     mock.expect_lookup_ip(domain);
    // }
}
