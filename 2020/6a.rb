p File.read('6.txt').split(/\n{2,}/).sum { |group|
  group.gsub("\n", "").chars.uniq.size
}
