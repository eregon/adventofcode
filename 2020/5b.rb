seats = Hash.new { |h,k| h[k] = [] }

File.readlines('5.txt', chomp: true).each { |line|
  /^(?<row>[FB]{7})(?<col>[LR]{3})$/ =~ line or raise line
  row = row.tr('FB', '01').to_i(2)
  col = col.tr('LR', '01').to_i(2)
  seats[row] << col
}

seats.each_pair.select { |row, cols|
  cols.size < 8 and !seats.keys.minmax.include?(row)
}.map { |row, cols| [row, *(8.times.to_a - cols)] }.each { |row, col|
  p row * 8 + col
}
