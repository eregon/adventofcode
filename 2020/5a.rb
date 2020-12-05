p File.readlines('5.txt', chomp: true).map { |line|
  /^(?<row>[FB]{7})(?<col>[LR]{3})$/ =~ line or raise line
  row = row.tr('FB', '01').to_i(2)
  col = col.tr('LR', '01').to_i(2)
  row * 8 + col
}.max
