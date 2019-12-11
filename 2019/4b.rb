input = (246540..787419)

p input.count { |n|
  n >= 100_000 and n < 1_000_000 and
  digits = n.digits.reverse and
  digits.each_cons(2).all? { |a,b| a <= b } and
  counts = Array.new(10, 0) and
  digits.each { |d| counts[d] += 1 } and
  counts.any? { |c| c == 2 }
}
