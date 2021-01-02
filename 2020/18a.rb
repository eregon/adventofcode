Integer.alias_method :-, :*
p File.readlines('18.txt', chomp: true).sum { |line|
  eval(line.gsub('*', '-'))
}
