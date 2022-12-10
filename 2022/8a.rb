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

visible = Set.new

define_method(:look) { |starts, dir|
  starts.each { |start|
    visible << start
    prev, pos = start, start + dir
    max_height = trees[start]
    while trees[pos]
      if trees[pos] > max_height
        visible << pos
        max_height = trees[pos]
      end
      prev, pos = pos, pos + dir
    end
  }
}

look grid.first, 1i
look grid.last, -1i
look grid.map(&:first), 1
look grid.map(&:last), -1

p visible.size
