require_relative 'lib'

coords = {}
start = 0i
finish = 0i

File.readlines('12.txt', chomp: true).each_with_index { |row, y|
  row.chars.each_with_index { |height, x|
    if height == 'S'
      start = x + y.i
      height = 'a'
    elsif height == 'E'
      finish = x + y.i
      height = 'z'
    end
    height = height.ord - 'a'.ord + 1
    coords[x + y.i] = height
  }
}

neighbors = -> coord {
  current = coords[coord]
  [coord - 1i, coord + 1, coord + 1i, coord - 1].select { |c|
    h = coords[c] and h <= current + 1
  }
}

def bfs(result, neighbors, stop)
  q = result.keys
  while c = q.shift
    neighbors[c].each { |neighbor|
      unless result.include? neighbor
        v = yield(c, neighbor)
        result[neighbor] = v
        return if stop[neighbor]
        q << neighbor
      end
    }
  end
end

result = { start => 0 }
bfs(result, neighbors, finish.method(:==)) { |prev, c|
  result[prev] + 1
}

p result[finish]
