require_relative 'lib'

map = File.readlines('9.txt', chomp: true).map { _1.chars.map(&Integer) }

coords = {}

map.each_with_index { |row, y|
  row.each_with_index { |depth, x|
    coords[x + y.i] = depth
  }
}

neighbors = -> coord {
  [coord - 1i, coord + 1, coord + 1i, coord - 1].select { |c| coords.include? c }
}

low_points = coords.select { |coord, depth|
  neighbors[coord].all? { |c| depth < coords[c] }
}.keys

def bfs(result, neighbors)
  q = result.keys
  while c = q.shift
    neighbors[c].each { |neighbor|
      unless result.include? neighbor
        v = yield(neighbor)
        result[neighbor] = v
        q << neighbor if v
      end
    }
  end
end

coord_to_basin = low_points.each_with_index.to_h

bfs(coord_to_basin, neighbors) { |c|
  if coords[c] == 9
    nil
  else
    neighbors[c].map { |n| coord_to_basin[n] }.compact.uniq.single
  end
}

p coord_to_basin.group_by { _2 }.to_h { [_1, _2.size] }.select { _1 != nil }.values.sort[-3..].reduce(:*)
