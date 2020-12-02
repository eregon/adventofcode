p File.readlines('2.txt', chomp: true).count { |line|
  /^(?<a>\d+)-(?<b>\d+) (?<c>.): (?<password>.+)$/ =~ line or raise line
  a, b = [a, b].map { |i| i.to_i - 1 }
  raise if a > password.size or b > password.size
  (password[a] == c) != (password[b] == c)
}
