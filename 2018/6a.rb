COORDS = File.readlines("6.txt", chomp: true).map { |line|
  x, y = line.split(", ").map { |n| Integer(n) }
  x + y.i
}.freeze

raise unless COORDS.uniq == COORDS

def distance(a, b)
  (a.real - b.real).abs + (a.imag - b.imag).abs
end

def compute_areas(range_x, range_y)
  areas = Hash.new(0)
  board = range_y.map { |y|
    range_x.map { |x|
      at = x + y.i
      a, b = COORDS.min_by(2) { |coord|
        distance(coord, at)
      }
      if distance(a, at) != distance(b, at)
        areas[a] += 1

        idx = COORDS.index(a)
        ch = if idx < 26
          ("a".ord + idx).chr
        else
          ("A".ord + (idx-26)).chr
        end
        a == at ? ch.swapcase : ch
      else
        "."
      end
    }
  }

  puts board.map(&:join)
  areas
end

min_x, max_x = COORDS.map(&:real).minmax
min_y, max_y = COORDS.map(&:imag).minmax

areas1 = compute_areas(min_x..max_x, min_y..max_y)
areas2 = compute_areas(min_x-1..max_x+1, min_y-1..max_y+1)

p COORDS.select { |coord| areas1[coord] == areas2[coord] }.map { |coord|
  areas1[coord]
}.max
