adapters = File.readlines('10.txt').map { Integer(_1) }
adapters << 0 << adapters.max + 3
increments = adapters.sort.each_cons(2).map { |a,b| b - a }.tally
p increments[1] * increments[3]
