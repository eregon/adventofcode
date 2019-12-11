input = File.read('10.txt')

asteroids = []
input.lines.each_with_index { |line,y|
  line.chomp.chars.each_with_index { |c,x|
    asteroids << x + y.i if c == '#'
  }
}
asteroids.freeze

width = input.lines[0].chomp.size
height = input.lines.size

p asteroids.map { |candidate|
  others = (asteroids - [candidate]).sort_by { |a|
    (a - candidate).abs
  }

  others.each { |other|
    v = other - candidate
    v /= v.real.gcd(v.imag)
    (1..).each { |m|
      d = other + v * m
      break unless d.real.between?(0, width-1) and
                   d.imag.between?(0, height-1)
      others.delete(d)
    }
  }

  [candidate, others.size]
}.max_by(&:last)
