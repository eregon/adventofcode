p ARGF.readlines.map { |line| line.chomp.chars }
  .transpose.map { |col| col.min_by { |e| col.count(e) } }.join
