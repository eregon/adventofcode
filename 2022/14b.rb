require_relative 'lib'

map = {}
source = 500 + 0i
map[source] = '+'

File.readlines('14.txt', chomp: true).each { |line|
  line.split(' -> ').each_cons(2) { |a,b|
    a = a.split(',').map(&Int).then { _1 + _2.i }
    b = b.split(',').map(&Int).then { _1 + _2.i }
    dir = (b - a) / (b - a).abs
    pos = a
    until pos == b + dir
      map[pos] = '#'
      pos += dir
    end
  }
}


x_range = Range.new(*map.keys.map(&:real).minmax)
y_range = Range.new(*map.keys.map(&:imag).minmax)
max_y = y_range.end

height = (y_range.end - y_range.begin) + 2

((source.real - height)..(source.real + height)).each { |x|
  map[x + (max_y + 2).i] = '#'
}

x_range = Range.new(*map.keys.map(&:real).minmax)
y_range = Range.new(*map.keys.map(&:imag).minmax)
max_y = y_range.end

show = -> {
  puts
  y_range.each { |y|
    puts x_range.map { |x|
      map[x + y.i] || '.'
    }.join
  }
}
show[]

simulate = -> {
  sand = source

  while true
    raise if sand.imag >= max_y

    below = sand + 1i
    if map[below].nil?
      sand = below
    elsif map[below - 1].nil?
      sand = below - 1
    elsif map[below + 1].nil?
      sand = below + 1
    else
      map[sand] = 'o'
      return false if sand == source
      break true
    end
  end
}

while simulate[]
  # show[]
end
show[]

p map.values.count('o')
