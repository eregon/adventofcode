claims = File.readlines("3.txt", chomp: true).map { |s|
  id, x, y, dx, dy = s.split(/\D+/).reject(&:empty?).map(&:to_i)
  [id, x...x+dx, y...y+dy]
}

fabric = Hash.new { |h,k| h[k] = Hash.new(0) }

claims.each { |id,xx,yy|
  yy.each { |y|
    xx.each { |x|
      fabric[y][x] += 1
    }
  }
}

p claims.find { |id,xx,yy|
  yy.all? { |y|
    xx.all? { |x|
      fabric[y][x] == 1
    }
  }
}[0]
