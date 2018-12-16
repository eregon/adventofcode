GRID_SERIAL_NUMBER = 9995

def power_level(x, y)
  rack_id = x + 10
  power = ((rack_id * y) + GRID_SERIAL_NUMBER) * rack_id
  raise if power < 0
  power = (power % 1000) / 100
  power - 5
end

RANGE = (1..300)
POWER = [0, *RANGE].map { |y|
  [0, *RANGE].map { |x|
    power_level(x, y)
  }
}

def best_square(size)
  best = nil
  best_score = -10 * size * size

  RANGE.each_cons(size) { |yy|
    RANGE.each_cons(size) { |xx|
      score = yy.sum { |y| xx.sum { |x| POWER[y][x] } }
      if score > best_score
        best = [xx[0], yy[0]]
        best_score = score
      end
    }
  }

  [best, best_score]
end

best, best_score = (1..20).map { |size|
  p size
  best, best_score = best_square(size)
  p [(best + [size]).join(','), best_score]
}.max_by(&:last)

p best_score
puts best
