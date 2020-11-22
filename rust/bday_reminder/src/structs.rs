use time::Date;

#[derive(Debug)]
pub struct BDay {
    first_name: String,
    month: u32,
    day: u32,
}

impl BDay {
    pub fn new(first_name: String, month: u32, day: u32) -> Self {
        BDay {
            first_name,
            month,
            day,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_bday_new() {
        let obj = BDay::new(String::from("test name"), 12, 30);

        assert_eq!(obj.first_name, "test name");
        assert_eq!(obj.month, 12);
        assert_eq!(obj.day, 30);
    }
}
