lines = ARGF.readlines.drop(2)

h = 28
w = 38

nodes = lines.map { |line|
  x, y, size, used, avail, use = line.scan(/\d+/).map(&:to_i)
  {x: x, y: y, size: size, used: used, avail: avail, use: use}
}

viable = 0
nodes.combination(2) { |a,b|
  if a[:used] > 0 and a[:used] <= b[:avail]
    # p [a[:used], b[:avail]]
    p a => b if b[:x] != 34 || b[:y] != 26
    viable += 1
  end
  if b[:used] > 0 and b[:used] <= a[:avail]
    viable += 1
    p b => a if a[:x] != 34 || a[:y] != 26
  end
}
p viable
