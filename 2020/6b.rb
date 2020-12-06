p File.read('6.txt').split(/\n{2,}/).sum { |group|
  persons = group.lines.map(&:chomp)
  persons.first.chars.count { |q| persons.all? { |person| person.include?(q) } }
}
