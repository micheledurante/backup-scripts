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
/// * `resolver` - A valid instance to perform DNS lookups
/// * `domain` - The domain to resolve to an IP address
fn lookup_domain(resolver: &Resolver, domain: &str) {
    let resolve_result = resolver.lookup_ip(domain);

    if resolve_result.is_err() {
        println!("{:?}", resolve_result.unwrap_err().kind());
    }
}

/// Given a list of domains, execute a DNS lookup.
///
/// * `domains` - The list of domains
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
        "micheledurante",
        "micheledurante.com",
    ];

    validate_domains(domains);
    Ok(())
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;
    use mockall::predicate::*;
    use mockall::*;
    use trust_dns_resolver::error::ResolveResult;
    use trust_dns_resolver::lookup_ip::LookupIp;

    #[automock]
    trait ResolverTrait {
        fn lookup_ip(&self, host: &str) -> ResolveResult<LookupIp>;
    }

    #[automock]
    trait MyTrait {
        fn foo(&self, x: u32) -> u32;
    }

    #[test]
    fn my_test() {
        let mut mock = MockMyTrait::new();
        mock.expect_foo().with(eq(4)).times(1).returning(|x| x + 1);
        assert_eq!(5, mock.foo(4));
    }

    #[test]
    fn test_lookup_domain_empty_string() {
        let mut mock = MockResolverTrait::new();
        let domain = "invalid-domain";

        mock.expect_lookup_ip()
            .with(domain)
            .times(1)
            .returning(|x| x);

        assert_eq!(domain, mock.expect_lookup_ip(domain));
    }

    #[test]
    fn test_lookup_domain_invalid() {}

    #[test]
    fn test_lookup_domain_valid() {}

    #[test]
    fn test_validate_domains_invalid() {}
}
