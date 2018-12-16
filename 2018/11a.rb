GRID_SERIAL_NUMBER = 9995

def power_level(x, y)
  rack_id = x + 10
  power = ((rack_id * y) + GRID_SERIAL_NUMBER) * rack_id
  raise if power < 0
  power = (power % 1000) / 100
  power - 5
end

range = (1..300)
power = [0, *range].map { |y|
  [0, *range].map { |x|
    power_level(x, y)
  }
}

best = nil
best_score = 0
range.each_cons(3) { |yy|
  range.each_cons(3) { |xx|
    score = yy.sum { |y| xx.sum { |x| power[y][x] } }
    if score > best_score
      best = [xx[0], yy[0]]
      best_score = score
    end
  }
}

p best_score
puts best.join(',')
