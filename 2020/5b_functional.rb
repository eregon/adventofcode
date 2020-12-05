seats = File.readlines('5.txt', chomp: true).map { |line|
  /^(?<row>[FB]{7})(?<col>[LR]{3})$/ =~ line or raise line
  row = row.tr('FB', '01').to_i(2)
  col = col.tr('LR', '01').to_i(2)
  [row, col]
}.group_by(&:first).transform_values { |v| v.map(&:last) }

seats.each_pair.select { |row, cols|
  cols.size < 8 and !seats.keys.minmax.include?(row)
}.map { |row, cols| [row, *(8.times.to_a - cols)] }.each { |row, col|
  p row * 8 + col
}
