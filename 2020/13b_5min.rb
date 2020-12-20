require_relative 'lib'
using Refinements

buses_with_offsets = File.readlines('13.txt', chomp: true).last.split(',').map {
  _1 == 'x' ? nil : _1.to_i
}.each_with_index.filter_map { |bus, i| [bus, i] if bus }.freeze

slowest_bus = buses_with_offsets.max

t0 = slowest_bus.reduce(:-)
until t0 % buses_with_offsets[0][0] == 0
  t0 += slowest_bus[0]
end

t1 = t0 + slowest_bus[0]
until t1 % buses_with_offsets[0][0] == 0
  t1 += slowest_bus[0]
end

t2 = t1 + slowest_bus[0]
until t2 % buses_with_offsets[0][0] == 0
  t2 += slowest_bus[0]
end

raise unless t2-t1 == t1-t0

inc = t1 - t0

code = <<RUBY
t = #{t0}
while true
  if #{(buses_with_offsets[1..-1] - [slowest_bus]).map { |bus, offset| "(t + #{offset}) % #{bus} == 0" }.join(' and ')}
    break p t
  end
  t += #{inc}
end
RUBY
puts code
eval code
