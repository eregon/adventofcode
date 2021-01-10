moves = File.readlines('24.txt', chomp: true).map { |line| line.scan(/e|se|sw|w|nw|ne/).map(&:to_sym) }

#  NW NE
# W  O  E
#  SW SE
# --> 1
# \
#  v
#   1

WHITE, BLACK = false, true

tiles = Hash.new(WHITE)

DIRS = {
  e:  0.i + 1,
  se: 1.i,
  sw: 1.i - 1,
  w:  0.i - 1,
  nw: -1.i,
  ne: -1.i + 1,
}.freeze

NEIGHBORS = DIRS.values.freeze

moves.each { |move|
  pos = 0 + 0.i
  move.each { |step| pos += DIRS[step] }
  tiles[pos] = !tiles[pos]
}

tiles.select! { |pos, color| color == BLACK }

100.times do
  next_tiles = Hash.new(WHITE)

  tiles.each_pair { |pos, color|
    raise unless color == BLACK
    neighbors = NEIGHBORS.map { |dir| pos + dir }

    blacks = neighbors.count { |at| tiles[at] == BLACK }
    next_tiles[pos] = BLACK if (1..2).include?(blacks)

    neighbors.each { |at|
      if tiles[at] == WHITE and NEIGHBORS.count { |dir| tiles[at + dir] == BLACK } == 2
        next_tiles[at] = BLACK
      end
    }
  }

  tiles = next_tiles
end
p tiles.size
