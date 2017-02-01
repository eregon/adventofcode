x, y = 0, 0
DIRS = [ # dx, dy
  [0, 1],
  [1, 0],
  [0, -1],
  [-1, 0],
]
dir = DIRS.first

visited = []
visited << [x,y]

ARGF.read.strip.split(", ").each { |move|
  turn, steps = move[0], Integer(move[1..-1])
  raise turn unless 'RL'.include? turn
  DIRS.rotate!(turn == 'R' ? 1 : -1)
  dir = DIRS.first
  dx, dy = dir
  steps.times do
    x += dx
    y += dy
    if visited.include?([x,y])
      p x.abs + y.abs
      exit
    end
    visited << [x,y]
  end
}
