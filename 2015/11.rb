pass = ARGV.first.dup

i = 0
loop {
  pass.succ!
  i += 1
  next if pass.include?('i') or pass.include?('o') or pass.include?('l')
  next unless /(.)\1.*(.)\2/ =~ pass and $1 != $2
  if pass.chars.each_cons(3).any? { |a,b,c| a.ord+1 == b.ord and b.ord+1 == c.ord }
    break
  end
  p i if i % 100 == 0
}

p i
puts pass
