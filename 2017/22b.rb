input = File.read("22.txt")

init_board = input.lines.map { |line| line.chomp.chars }

board = Hash.new('.')
init_board.each_with_index { |row, i|
  row.each_with_index { |v, j| board[j+i.i] = v }
}

pos = (init_board[0].size/2) + (init_board.size/2).i
dir = -1i
infections = 0

dirs = [-1i, 1, 1i, -1] * 2

10_000_000.times {
  board[pos] = case board[pos]
  when '.'
    dir = dirs[dirs.index(dir)-1]
    'W'
  when 'W'
    infections += 1
    '#'
  when '#'
    dir = dirs[dirs.index(dir)+1]
    'F'
  when 'F'
    dir = dirs[dirs.index(dir)+2]
    '.'
  end
  pos += dir
}

p infections
