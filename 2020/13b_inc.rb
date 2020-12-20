require_relative 'lib'
using Refinements

buses_with_offsets = File.readlines('13.txt', chomp: true).last.split(',').map {
  _1 == 'x' ? nil : _1.to_i
}.each_with_index.filter_map { |bus, i| [bus, i] if bus }.freeze

start = 0
inc = 1
buses_with_offsets.each { |bus, offset|
  t0 = start
  until (t0 + offset) % bus == 0
    t0 += inc
  end
  start = t0

  t1 = t0 + inc
  until (t1 + offset) % bus == 0
    t1 += inc
  end

  t2 = t1 + inc
  until (t2 + offset) % bus == 0
    t2 += inc
  end

  raise unless t2-t1 == t1-t0
  inc = t1 - t0
}
p start
