x, y = 0, 0
DIRS = [[0, 1], [1, 0], [0, -1], [-1, 0]]
dir = DIRS.first
ARGF.read.strip.split(", ").each { |move|
  turn, steps = move[0], Integer(move[1..-1])
  raise turn unless 'RL'.include? turn
  DIRS.rotate!(turn == 'R' ? 1 : -1)
  dir = DIRS.first
  dx, dy = dir
  x += dx * steps
  y += dy * steps
}

p x.abs + y.abs
