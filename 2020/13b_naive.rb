require_relative 'lib'
using Refinements

buses_with_offsets = File.readlines('13sample2.txt', chomp: true).last.split(',').map {
  _1 == 'x' ? nil : _1.to_i
}.each_with_index.filter_map { |bus, i| [bus, i] if bus }.freeze

slowest_bus = buses_with_offsets.max

p Enumerator.produce(slowest_bus.reduce(:-)) { |t| t + slowest_bus[0] }.find { |t|
  buses_with_offsets.all? { |bus, offset|
    (t + offset) % bus == 0
  }
}

# p Enumerator.produce(0, &:succ).find { |t|
#   buses_with_offsets.all? { |bus, offset|
#     (t + offset) % bus == 0
#   }
# }
