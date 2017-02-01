p ARGF.each_line.count { |line|
  word = line.chomp
  word =~ /(..).*\1/ and word =~ /(.).\1/
}
