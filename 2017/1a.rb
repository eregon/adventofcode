input = File.read("1.txt")
digits = input.strip.chars.map { |e| Integer(e) }

p (digits + [digits.first]).each_cons(2).select { |a,b| a == b }.sum(&:first)

sum = 0
cycle = digits.cycle
digits.size.times do
  a = cycle.next
  b = cycle.peek
  sum += a if a == b
end
p sum
