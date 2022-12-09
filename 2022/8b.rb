require_relative 'lib'
require 'set'

trees = {}

grid = File.readlines('8.txt', chomp: true).map.with_index { |line, y|
  line.chars.map(&Int).map.with_index { |height, x|
    pos = x+y.i
    trees[pos] = height
    pos
  }
}

define_method(:look) { |start, dir|
  prev, pos = start, start + dir
  h = trees[start]
  see = 0
  while trees[pos] and trees[pos] < h
    see += 1
    prev, pos = pos, pos + dir
  end
  see += 1 if trees[pos]
  see
}

border = grid.first + grid.last + grid.map(&:first) + grid.map(&:last)
middle = trees.keys - border
p middle.map { |pos|
  look(pos, 1) * look(pos, -1) * look(pos, 1i) * look(pos, -1i)
}.max
