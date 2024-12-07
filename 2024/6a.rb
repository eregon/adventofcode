map = {}
$<.map(&:chomp).each_with_index { |row,y|
  row.chars.each_with_index { |c,x|
    map[x+y.i] = c
  }
}

dirs = [-1i, 1, 1i, -1] * 2

pos = map.key('^')
dir = dirs[0]
while map[pos]
  map[pos] = 'X'
  while map[pos + dir] == '#'
    dir = dirs[dirs.index(dir)+1]
  end
  pos += dir
end
p map.values.count('X')