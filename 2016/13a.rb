# frozen-string-literal: true

FAV = 1358 # 10
GOAL = [31, 39] # [7, 4]

def at(x, y)
  val = x*x + 3*x + 2*x*y + y + y*y + FAV
  binary = val.to_s 2
  ones = binary.count("1")
  ones.even? ? "." : "#"
end

h, w = 100, 100 # h, w = 7, 10
building = h.times.map { |y|
  w.times.map { |x|
    at(x, y)
  }
}

puts building.map(&:join)

def bfs(board, start)
  dist = Hash.new(Float::INFINITY)
  q = [start]
  dist[start] = 0
  h, w = board.size, board[0].size

  until q.empty?
    x,y = pos = q.shift
    d = dist[pos]
    return d if pos == GOAL
    [[x+1,y], [x,y+1], [x-1,y], [x,y-1]].select { |x,y|
      y >= 0 and x >= 0 and board.dig(y,x) == "."
    }.each { |pos|
      if d+1 < dist[pos]
        dist[pos] = d+1
        q << pos
      end
    }
  end
end

p bfs(building, [1,1])

