n = 50
str = ARGV.first

n.times {
  # fun fact: :+ instead of :<< makes it quadratic there and never ends ...
  str = str.each_char.chunk { |c| c }.map { |c,g| "#{g.size}#{c}" }.reduce(:<<)
}

#puts str
p str.size
