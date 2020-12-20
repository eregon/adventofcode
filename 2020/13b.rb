require_relative 'lib'
using Refinements

buses_with_offsets = File.readlines('13.txt', chomp: true).last.split(',').map {
  _1 == 'x' ? nil : _1.to_i
}.each_with_index.filter_map { |bus, i| [bus, i] if bus }.freeze

t = 0
inc = 1
buses_with_offsets.each { |bus, offset|
  t += inc until (t + offset) % bus == 0
  inc *= bus # Chinese remainder theorem
}
p t
