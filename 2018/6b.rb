COORDS = File.readlines("6.txt", chomp: true).map { |line|
  x, y = line.split(", ").map { |n| Integer(n) }
  x + y.i
}.freeze

def distance(a, b)
  (a.real - b.real).abs + (a.imag - b.imag).abs
end

def compute_area(range_x, range_y)
  range_y.sum { |y|
    range_x.count { |x|
      at = x + y.i
      COORDS.sum { |coord| distance(coord, at) } < 10_000
    }
  }
end

range_x = COORDS.map(&:real).minmax.reduce(&Range.method(:new))
range_y = COORDS.map(&:imag).minmax.reduce(&Range.method(:new))

p compute_area(range_x, range_y)
