require 'set'

goals = []

board = ARGF.readlines.map.with_index { |line, y|
  line.chomp.chars.map.with_index { |cell, x|
    case cell
    when "#"
      "#"
    when "."
      "."
    when "0".."9"
      goals[Integer(cell)] = [x,y]
      cell #{ }"."
    else
      raise cell
    end
  }
}

puts board.map { |row| row.join }

p goals

# dist = Array.new(goals.size) { Array.new(goals.size, 0) }

# goals.

def bfs(start, board)
  dist = Hash.new(Float::INFINITY)
  prev = {}
  dist[start] = 0
  q = [start]
  visited = Set.new
  while n = q.shift
    next if visited.include? n
    visited << n
    pr = prev[n]
    x, y = n
    d = dist[n]
    # p [x,y,d]
    [[x-1,y], [x+1,y], [x,y+1], [x,y-1]].each { |x,y|
      alt = [x,y]
      if y >= 0 and y >= 0 and board.dig(y, x) != '#' and alt != pr
        prev[alt] = n
        dist[alt] = d+1
        q << alt
      end
    }
  end
  dist
end

dist = goals.map { |g|
  d = bfs(g, board)
  goals.map { |g| d[g] }
}

puts dist.map { |row| row.join(' ') }

p (1...goals.size).to_a.permutation.size

def total(perm, dist)
  perm.each_cons(2).inject(dist[0][perm[0]]) { |d,(a,b)| d + dist[a][b] } + dist[perm.last][0]
end

best = (1...goals.size).to_a.permutation.min_by { |perm|
  total(perm, dist)
}

p best

p total(best, dist)
