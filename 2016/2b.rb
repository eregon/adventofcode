DIRS = {
  'D' => [0, 1],
  'R' => [1, 0],
  'U' => [0, -1],
  'L' => [-1, 0]
}

n = nil
keypad = [
  [n, n, 1, n, n],
  [n, 2, 3, 4, n],
  [5, 6, 7, 8, 9],
  [n,?A,?B,?C, n],
  [n, n,?D, n, n],
]

x, y = 0, 2
code = ARGF.each_line.map { |moves|
  moves.chomp.each_char { |move|
    dir = DIRS[move]
    raise move unless dir
    dx, dy = dir
    if (x+dx).between?(0, 4) and (y+dy).between?(0, 4) and keypad[y+dy][x+dx]
      x += dx
      y += dy
    end
  }
  keypad[y][x]
}

puts code * ''
