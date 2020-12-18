File.readlines('9.txt').map { Integer(_1) }.each_cons(25+1) { |*prev, n|
  p n if prev.combination(2).none? { |a,b| a + b == n }
}
