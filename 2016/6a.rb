p ARGF.readlines.map { |line| line.chomp.chars }
  .transpose.map { |col| col.max_by { |e| col.count(e) } }.join
