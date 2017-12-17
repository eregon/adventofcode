n = Integer(ARGV[0] || 50_000_000)
steps = 314
pos = 0
after_zero = 0

n.times do |i|
  n = i+1
  pos = (pos + steps) % n
  after_zero = n if pos == 0
  pos += 1
end

p after_zero
