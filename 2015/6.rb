N = 1000

grid = Array.new(N) { Array.new(N, false) }

actions = {
  "turn on" => -> v { true },
  "turn off" => -> v { false },
  "toggle" => -> v { not v}
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

p grid.map { |row| row.count(true) }.reduce(:+)
