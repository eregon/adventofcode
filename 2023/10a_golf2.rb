board = $<.map { |row|
  row.chomp
}

pp board
sr = board.index { _1.index('S') }
start = [sr,board[sr].index('S')]

dirs = { ?L => [1,-1i], ?J => [-1,-1i], ?7 => [-1,1i], ?F => [1,1i], ?- => [-1,1], ?| => [-1i,1i] }

map[start] = dirs.key([1,-1,1i,-1i].filter_map { |d| d if map[start+d] and dirs[map[start+d]].any? { -_1==d } })

pos = start + dirs[map[start]][0]

enum = Enumerator.produce([start, pos]) do |prev, pos|
  a, b = dirs[map[pos]]
  if pos + a != prev
    [pos, pos + a]
  else
    [pos, pos + b]
  end
end

p (enum.find_index { _2 == start }+1)/2
