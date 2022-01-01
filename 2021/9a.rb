require_relative 'lib'

map = File.readlines('9.txt', chomp: true).map { _1.chars.map(&Integer) }

coords = {}

map.each_with_index { |row, y|
  row.each_with_index { |depth, x|
    coords[x + y.i] = depth
  }
}

p coords.select { |coord, depth|
  [coord - 1i, coord + 1, coord + 1i, coord - 1].select { |c|
    coords.include? c
  }.all? { |c| depth < coords[c] }
}.values.sum { _1 + 1 }
