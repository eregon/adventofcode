VOWELS = %w[a e i o u]
NAUGHTY = %w[ab cd pq xy]

p ARGF.each_line.count { |line|
  word = line.chomp.chars
  word.count { |c| VOWELS.include?(c) } >= 3 and
  word.each_cons(2).any? { |a,b| a == b } and
  word.each_cons(2).none? { |a,b| NAUGHTY.include?(a+b) }
}
