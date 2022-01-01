require_relative 'lib'

crabs = File.read('7.txt').chomp.split(',').map(&Integer)

p Range.new(*crabs.minmax).map { |pos|
  cost = crabs.sum { |i| n = (i - pos).abs and (n * n.succ) / 2 }
  [cost, pos]
}.min.first
