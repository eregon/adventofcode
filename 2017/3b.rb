input = 368078

NEIGHBORS = [
  -1-1i, -1i, 1-1i,
  -1,         1,
  -1+1i,  1i, 1+1i,
]

spiral = [[1]]
side = 0
max = 1
off = 0

compute_value = -> pos {
  spiral[pos.imag+off][pos.real+off] = NEIGHBORS.map { |delta|
    neighbor = pos + delta
    x, y = neighbor.real+off, neighbor.imag+off
    spiral[y][x] if y >= 0 and x >= 0 and spiral[y]
  }.sum(&:to_i)
}

show = -> {
  puts
  spiral.each { |row| puts row.map(&:inspect).join("\t") }
}

while input > max
  side += 2
  r = side/2
  off = side/2
  spiral = [[nil]*(side+1)] + spiral.map { |row| [nil, *row, nil] } + [[nil]*(side+1)]

  (side-1).times do |dy|
    compute_value[(r) + (r-1-dy).i]
  end
  side.times do |dx|
    compute_value[(r-dx) + (-r).i]
  end
  side.times do |dy|
    compute_value[(-r) + (-r+dy).i]
  end
  side.times do |dx|
    compute_value[(-r+dx) + (r).i]
  end
  max = compute_value[r + r.i]

  show[]
end
