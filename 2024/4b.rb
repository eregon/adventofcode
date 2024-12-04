rows = $<.map{it.chomp.chars}

map = {}
rows.each_with_index { |row,y|
  row.each_with_index { |c,x|
    map[x+y.i] = c
  }
}

p map.each_pair.count { |pos,c|
  c == "A" and [[1+1i, -1-1i], [1-1i, -1+1i]].count { |d,e|
    [map[pos+d], map[pos+e]].sort_by(&:to_s) == %w[M S]
  } >= 2
}