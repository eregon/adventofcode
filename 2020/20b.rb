require_relative 'lib'
using Refinements

class Tile
  attr_reader :id, :rows, :borders, :normalized_borders, :neighbors
  def initialize(id, rows)
    @id = id
    @rows = rows
    @borders = [rows[0], rows.map { _1[-1] }, rows[-1], rows.map { _1[0] }]
    @normalized_borders = @borders.map { normalize(_1) }
    @neighbors = Array.new(4)
  end

  def attach(bi, other, oi)
    raise unless @normalized_borders[bi] == other.normalized_borders[oi]
    if other.neighbors[oi] != self && !other.neighbors.all?(&:nil?)
      raise "#{other} already has neighbors: #{other.neighbors}[#{oi}]; #{self} #{neighbors}[#{bi}]"
    end

    until (bi-oi).abs == 2
      other.rotate_right
      oi = (oi + 1) % 4
    end
    raise unless (bi-oi).abs == 2

    unless @borders[bi] == other.borders[oi]
      raise unless @borders[bi] == other.borders[oi].reverse
      if oi.even?
        other.flip_horizontally
      else
        other.flip_vertically
      end
    end
    raise unless @borders[bi] == other.borders[oi]

    @neighbors[bi] = other
  end

  def rotate_right
    replace Tile.new(@id, rows.rotate_right)
  end

  def flip_horizontally
    replace Tile.new(@id, rows.flip_horizontally)
  end

  def flip_vertically
    replace Tile.new(@id, rows.flip_vertically)
  end

  def replace(other)
    raise @neighbors.to_s if $check and !@neighbors.all?(&:nil?)
    @rows = other.rows
    @borders = other.borders
    @normalized_borders = other.normalized_borders
  end

  def normalize(border)
    a = Integer(border.join, 2)
    b = Integer(border.join.reverse, 2)
    [a, b].min
  end

  def to_s
    "#{@id}"
  end
  alias inspect to_s
end

tiles = File.read('20.txt').split("\n\n").map { |chunk|
  chunk.lines.then { |id,*lines|
    Tile.new(Integer(id[/\d+/]), lines.map { |line| line.chomp.tr('#.', '10').chars })
  }
}

SIDE = Integer.sqrt(tiles.size)

corresponding_tiles = tiles.flat_map(&:normalized_borders).tally.values.tally
unless corresponding_tiles == { 1 => SIDE * 4, 2 => (tiles.size - SIDE) * 4 / 2 }
  raise corresponding_tiles.to_s
end

$check = true

visited = {}
todo = [tiles.first]
while current = todo.shift
  visited[current] = true
  current.normalized_borders.each_with_index { |border, bi|
    other = tiles.find { |other| other != current and other.normalized_borders.include?(border) }
    if other
      oi = other.normalized_borders.index(border)
      current.attach(bi, other, oi)
      todo << other unless visited.include?(other)
    end
  }
end

$check = false

top_left = tiles.find { |tile|
  tile.normalized_borders.values_at(0, 3).all? { |border|
    tiles.none? { |other_tile|
      tile != other_tile and other_tile.normalized_borders.include?(border)
    }
  }
}

board = SIDE.times.map { |y|
  first_in_row = top_left
  y.times { first_in_row = first_in_row.neighbors[2] }
  SIDE.times.map { |x|
    tile = first_in_row
    x.times { tile = tile.neighbors[1] }
    tile
  }
}

def board.to_s
  out = +''
  self.each { |row|
    in_row = row.map { |tile|
      Matrix2D.new(tile.rows[1...-1].map { _1[1...-1] }).map { |cell,|
        cell.tr('10', '#.')
      }.rows.map(&:join)
    }
    out << in_row.transpose.map { _1.join('') }.join("\n") << "\n"
  }
  out
end

SEA_MONSTER = <<MONSTER
                  #
#    ##    ##    ###
 #  #  #  #  #  #
MONSTER

SEA_MONSTER_MARKS = SEA_MONSTER.lines.map { |line|
  line.chomp.chars.map.with_index.select { |c,i| c == '#' }.map(&:last)
}

MONSTER_REGEXPS = SEA_MONSTER.lines.map(&:chomp).map.with_index { |line, i|
  /#{'\G' if i != 1}#{line.tr(' ', '.')}/
}

def matches?(str)
  if start1 = MONSTER_REGEXPS[1] =~ str
    line_length = str.lines.first.size
    start0 = start1 - line_length
    start2 = start1 + line_length
    if str.match(MONSTER_REGEXPS[0], start0) and str.match(MONSTER_REGEXPS[2], start2)
      start0
    end
  end
end

def search(board)
  tiles = board.flatten(1)

  order = [:rotate_right] * 4 +
    [:flip_vertically] +
    [:rotate_right] * 4 +
    [:flip_horizontally] +
    [:rotate_right] * 4

  order.each { |transformation|
    str = board.to_s
    line_length = str.lines.first.size
    if matches?(str)
      monsters = 0
      while start = matches?(str)
        SEA_MONSTER_MARKS.each_with_index { |cols, line|
          cols.each { |col|
            offset = start + line * line_length + col
            raise unless str[offset] == '#'
            str[offset] = 'O'
          }
        }
        monsters += 1
      end

      p monsters
      return str
    else
      tiles.each(&transformation)
      board.replace board.then(&transformation)
    end
  }
end

puts str = search(board)
p str.count('#')
