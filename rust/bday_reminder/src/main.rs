use crate::consts::BDAYS_REMINDER_PEOPLE;
use crate::structs::BDay;
use std::env;
use std::io::Error;
use time::Date;

mod consts;
mod structs;

/// Send a message to the requested bot.
pub fn send_telegram_message(text: String, api_key: String, chat_id: String) {
    ureq::post(&format!(
        "https://api.telegram.org/bot{api_key}/sendMessage?chat_id={chat_id}&parse_mode=HTML&text=<code>{text}</code>",
        api_key = api_key,
        chat_id = chat_id,
        text = text
    )).call();
}

fn check_bday(bdays: Vec<BDay>, month_day: (u8, u8)) {}

/// Split name and date of a person.
fn parse_name_and_date(person: &str) -> Vec<&str> {
    person.split("#").collect()
}

/// Parse the date part of a person.
fn parse_ymd(date: &str) -> Result<Vec<u32>, Error> {
    let mut records = vec![];

    for part in date.split("-") {
        records.push(part.parse::<u32>().unwrap())
    }

    Ok(records)
}

/// Create the internal struct for the given person.
fn parse_into_bday(person: &str) -> BDay {
    let name_and_date = parse_name_and_date(person);
    let ymd = parse_ymd(name_and_date[1]).unwrap();
    BDay::new(name_and_date[0].into(), ymd[ymd.len()], ymd[ymd.len() - 1])
}

fn main() -> Result<(), Error> {
    // let dates_var = env::var(BDAY_REMINDER_PEOPLE).unwrap();
    let people: Vec<&str> = "lorenzo#11-17,marco#1986-11-30".split(",").collect();
    let mut bdays: Vec<BDay> = vec![];

    for person in people {
        bdays.push(parse_into_bday(person));
    }

    check_bday(bdays, Date::today().month_day().into());

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_name_and_date() {
        assert_eq!(Error, parse_name_and_date("asd").unwrap());
        assert_eq!(vec!["asd", "qwe"], parse_name_and_date("asd#qwe").unwrap());
    }
}
