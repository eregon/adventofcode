require_relative 'lib'

crabs = File.read('7.txt').chomp.split(',').map(&Integer)

p Range.new(*crabs.minmax).map { |pos|
  cost = crabs.sum { |i| (i - pos).abs }
  [cost, pos]
}.min.first
