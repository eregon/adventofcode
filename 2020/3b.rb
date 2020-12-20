require_relative 'lib'
using Refinements

map = File.readlines('3.txt', chomp: true).map { |line|
  RepeatingArray.new line.chars.map { |c| c == '#' }
}

p [1+1i, 3+1i, 5+1i, 7+1i, 1+2i].map { |slope|
  Enumerator.produce([0 + 0.i, 0]) { |pos, trees|
    [
      pos + slope,
      trees + map[pos.imag][pos.real].to_i
    ]
  }.find { |pos,| pos.imag >= map.size }.last
}.reduce(:*)
