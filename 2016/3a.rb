p ARGF.each_line.count { |line|
  a, b, c = line.chomp.split.map { |e| Integer(e) }
  a+b > c and b+c > a and c+a > b
}
