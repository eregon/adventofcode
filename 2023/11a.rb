board = $<.readlines(chomp: true).map(&:chars)

2.times do
  empty = board.zip(0..).filter_map { |row,i| i if row.all?('.') }
  empty.reverse.each { |i| board[i..i] = [board[i], board[i]] }
  board = board.transpose
end

galaxies = []
board.each_with_index do |row,y|
  row.each_with_index { |c,x|
    galaxies << x + y.i if c == '#'
  }
end

p galaxies.combination(2).sum { |a,b| (a-b).rect.sum(&:abs) }
