tiles = File.read('20.txt').split("\n\n").to_h { |chunk|
  chunk.lines.then { |id,*lines|
    [Integer(id[/\d+/]), lines.map { |line| line.chomp.tr('#.', '10').chars }]
  }
}

def normalize(border)
  a = Integer(border.join, 2)
  b = Integer(border.join.reverse, 2)
  [a, b].min
end

borders = tiles.to_h { |id, tile|
  [
    id,
    [
      normalize(tile[0]),
      normalize(tile[-1]),
      normalize(tile.map { _1[0] }),
      normalize(tile.map { _1[-1] }),
    ]
  ]
}

corners = tiles.select { |id, tile|
  borders[id].count { |border|
    borders.none? { |other_id, other_borders|
      id != other_id and other_borders.include?(border)
    }
  } == 2
}

p corners.keys.reduce(:*)
