claims = File.readlines("3.txt", chomp: true).map { |s|
  id, x, y, dx, dy = s.split(/\D+/).reject(&:empty?).map(&:to_i)
  [x...x+dx, y...y+dy]
}

fabric = Hash.new { |h,k| h[k] = Hash.new(0) }
claims.each { |xx,yy|
  yy.each { |y|
    xx.each { |x|
      fabric[y][x] += 1
    }
  }
}

p fabric.values.sum { |row| row.values.count { |v| v >= 2 } }
