N = 1000

grid = Array.new(N) { Array.new(N, 0) }

actions = {
  "turn on" => -> v { v+1 },
  "turn off" => -> v { [v-1,0].max },
  "toggle" => -> v { v+2 }
}

ARGF.each_line { |line|
  /^([a-z ]+) (\d+),(\d+) through (\d+),(\d+)$/ =~ line
  _, sx, sy, tx, ty = $~.captures.map(&:to_i)
  (sx..tx).each { |x|
    (sy..ty).each { |y|
      grid[y][x] = actions[$1].call(grid[y][x])
    }
  }
}

p grid.map { |row| row.reduce(:+) }.reduce(:+)
