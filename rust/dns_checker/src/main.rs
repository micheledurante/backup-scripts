use std::io::Error;
use trust_dns_resolver::Resolver;

fn validate_domains() {
    let domains = vec![
        "annikaschall.com",
        "micheledurante.co.uk",
        "micheledurante",
        "micheledurante.com",
    ];

    let resolver = Resolver::from_system_conf().unwrap();

    for domain in domains {
        let response = resolver.lookup_ip(domain);

        if response.is_err() {
            println!("{:?}", response.unwrap_err().kind());
        }
    }
}

fn main() -> Result<(), Error> {
    validate_domains();

    Ok(())
}
