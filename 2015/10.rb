n = 40
str = ARGV.first

n.times {
  str = str.each_char.chunk { |c| c }.map { |c,g| "#{g.size}#{c}" }.reduce(:<<)
}

#puts str
p str.size
