require_relative 'lib'
using Refinements

class RepeatingArray
  def initialize(array)
    @array = array
  end

  def [](i)
    @array[i % @array.size]
  end
end

map = File.readlines('3.txt', chomp: true).map { |line|
  RepeatingArray.new line.chars.map { |c| c == '#' }
}

p Enumerator.produce([0 + 0i, 0]) { |pos, trees|
  [
    pos + 3 + 1i,
    trees + map[pos.imag][pos.real].to_i
  ]
}.find { |pos,| pos.imag >= map.size }.last
