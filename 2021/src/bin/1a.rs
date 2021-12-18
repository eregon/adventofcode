fn main() {
    println!("{}", include_str!("../../1.txt").lines()
        .map(|line| line.parse::<i64>().unwrap())
        .collect::<Vec<_>>()
        .windows(2).filter(|s| s[0] < s[1]).count());
}
