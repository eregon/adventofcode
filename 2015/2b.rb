p ARGF.readlines.map(&:chomp).inject(0) { |total,box|
  sides = box.split('x').map { |e| Integer(e) }
  total + sides.min(2).reduce(:+) * 2 + sides.reduce(:*)
}
