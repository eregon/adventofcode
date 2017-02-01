p ARGF.each_line.to_a.each_slice(3).map { |rows|
  rows.map { |row|
    row.chomp.split.map { |e| Integer(e) }
  }.transpose.count { |triangle|
    a, b, c = triangle
    a+b > c and b+c > a and c+a > b
  }
}.reduce(0, :+)
