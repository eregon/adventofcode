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
  e:  0i + 1,
  se: 1i,
  sw: 1i - 1,
  w:  0i - 1,
  nw: -1i,
  ne: -1i + 1,
}.freeze

moves.each { |move|
  pos = 0 + 0i
  move.each { |step| pos += DIRS[step] }
  tiles[pos] = !tiles[pos]
}

p tiles.values.count(BLACK)
