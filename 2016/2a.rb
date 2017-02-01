DIRS = {
  'D' => [0, 1],
  'R' => [1, 0],
  'U' => [0, -1],
  'L' => [-1, 0]
}

keypad = 3.times.map { |y|
  3.times.map { |x|
    y*3 + x+1
  }
}

x, y = 1, 1
code = ARGF.each_line.map { |moves|
  moves.chomp.each_char { |move|
    dir = DIRS[move]
    raise move unless dir
    dx, dy = dir
    if (x+dx).between?(0,2) and (y+dy).between?(0,2)
      x += dx
      y += dy
    end
  }
  keypad[y][x]
}

puts code * ''
