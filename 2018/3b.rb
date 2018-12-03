claims = File.readlines("3.txt", chomp: true).map { |s|
  s =~ /(#\d+) @ (\d+),(\d+): (\d+)x(\d+)/
  [$1, $2.to_i...($2.to_i+$4.to_i), $3.to_i...($3.to_i+$5.to_i)]
}

fabric = Hash.new { |h,k| h[k] = Hash.new(0) }

claims.each { |id,xx,yy|
  yy.each { |y|
    xx.each { |x|
      fabric[y][x] += 1
    }
  }
}

puts claims.find { |id,xx,yy|
  yy.all? { |y|
    xx.all? { |x|
      fabric[y][x] == 1
    }
  }
}[0]
