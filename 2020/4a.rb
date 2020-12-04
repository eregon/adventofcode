FIELDS = %w[byr iyr eyr hgt hcl ecl pid]
p File.read('4.txt').split(/\n{2,}/).map { |lines|
  lines.split.map { |kv| kv[/^(\w+):/, 1] }
}.count { |fields| (FIELDS - fields).empty? }
