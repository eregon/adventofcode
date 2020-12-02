p File.readlines('2.txt', chomp: true).count { |line|
  /^(?<min>\d+)-(?<max>\d+) (?<c>.): (?<password>.+)$/ =~ line or raise line
  (password.chars.tally[c] || 0).between?(min.to_i, max.to_i)
}
