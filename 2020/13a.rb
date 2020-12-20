require_relative 'lib'
using Refinements

now, buses = File.readlines('13.txt', chomp: true).then {
  [_1.to_i, (_2.split(',') - ['x']).map(&:to_i)]
}

p buses.map { |bus| [bus, bus - now % bus] }.min_by { _2 }.reduce(:*)
