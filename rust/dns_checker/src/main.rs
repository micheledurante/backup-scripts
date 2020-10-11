/**
 * By default, Rust variables are passed by "copy" or "move". You need to expressly use ref in
 * function declarations!!!
 *
 * @see https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html
 */
use std::io::Error;
use trust_dns_resolver::Resolver;

/// Perform a dns lookup for the given domain.
///
/// * `resolver` - A valid instance to perform DNS lookups.
/// * `domain` - The domain to resolve to an IP address.
fn lookup_domain(resolver: &Resolver, domain: &str) {
    let response = resolver.lookup_ip(domain);

    if response.is_err() {
        println!("{:?}", response.unwrap_err().kind());
    }
}

fn validate_domains() {
    let domains = vec![
        "annikaschall.com",
        "micheledurante.co.uk",
        "micheledurante",
        "micheledurante.com",
    ];

    let resolver = Resolver::from_system_conf().unwrap();

    for domain in &domains {
        lookup_domain(&resolver, domain)
    }
}

fn main() -> Result<(), Error> {
    validate_domains();
    Ok(())
}
