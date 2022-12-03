use std::io::{self, BufRead};

fn main() -> io::Result<()> {
    let mut total: u32 = 0;
    let mut badgetotal: u32 = 0;
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let mut a: String = "".to_string();
    let mut b: String = "".to_string();
    let mut c: String;
    let mut iterator = 0;

    while let Some(line) = lines.next() {
        let line2 = line.unwrap();
        let length = line2.len();
        let (first, second) = line2.trim().split_at((length / 2).try_into().unwrap());

        for char in first.chars() {
            if second.contains(char) {
                let value = char as u32;
                if value > 96 {
                    total += value - 96;
                }
                else {
                    total += value - 38;
                }
                break;
            }
        }
        if iterator % 3 == 0 {
            a = line2.clone().to_owned();
        }
        if iterator % 3 == 1 {
            b = line2.clone().to_owned();
        }
        if iterator % 3 == 2 {
            c = line2.clone().to_owned();

            for char in a.chars() {
                if b.contains(char) {
                    if c.contains(char) {
                        let value = char as u32;
                        if value > 96 {
                            badgetotal += value - 96;
                        }
                        else {
                            badgetotal += value - 38;
                        }
                        break;
                    }
                }
            }
        }
        iterator += 1;
    }

    println!("{total}");
    println!("{badgetotal}");
    Ok(())
}
