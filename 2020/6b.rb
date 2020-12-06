p File.read('6.txt').split(/\n{2,}/).sum { |group|
  persons = group.lines.size
  group.gsub("\n", "").chars.tally.count { |q,c| c == persons }
}
