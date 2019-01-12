clay = File.readlines(ARGV[0] || "17.txt", chomp: true).map { |line|
  coords = { x: nil, y: nil }
  line.split(", ").map { |part|
    var, range = part.split('=')
    range = eval(range)
    range = (range..range) unless Range === range
    coords[var.to_sym] = range
  }
  coords
}

min_y = clay.map { |c| c[:y].begin }.min
max_y = clay.map { |c| c[:y].end }.max
range_y = (min_y..max_y)

min_x = clay.map { |c| c[:x].begin }.min-1
max_x = clay.map { |c| c[:x].end }.max+1
range_x = (min_x..max_x)

map = Hash.new(:sand)
clay.each { |c|
  c[:y].each { |y|
    c[:x].each { |x|
      map[x + y.i] = :clay
    }
  }
}

show = -> {
  range_y.each { |y|
    puts range_x.map { |x|
      case map[x+y.i]
      when :sand then "."
      when :clay then "#"
      when :moving then "|"
      when :still then "~"
      else raise
      end
    }.join
  }
  puts
}

class Symbol
  def free?
    equal?(:sand) or equal?(:moving)
  end

  def filled?
    equal?(:clay) or equal?(:still)
  end

  def watery?
    equal?(:moving) or equal?(:still)
  end

  def still?
    equal?(:still)
  end
end

spring = 500 + 0.i
drops = [spring]

until drops.empty?
  drops = drops.flat_map do |drop|
    below = drop + 1.i
    if map[below] == :sand
      map[below] = :moving
      below
    elsif map[below].filled?
      left = below
      while map[left].filled? and map[left-1.i].free?
        left -= 1
      end
      right = below
      while map[right].filled? and map[right-1.i].free?
        right += 1
      end

      wall_on_left = map[left].filled? and map[left-1.i] == :clay
      wall_on_right = map[right].filled? and map[right-1.i] == :clay

      if wall_on_left and wall_on_right
        ((left+1).real..(right-1).real).each { |x|
          map[x + drop.imag.i] = :still
        }
        drop - 1.i
      elsif wall_on_left and !wall_on_right
        ((left+1).real..right.real).each { |x|
          map[x + drop.imag.i] = :moving
        }
        right.real + drop.imag.i
      elsif !wall_on_left and wall_on_right
        (left.real..(right-1).real).each { |x|
          map[x + drop.imag.i] = :moving
        }
        left.real + drop.imag.i
      elsif !wall_on_left and !wall_on_right
        (left.real..right.real).each { |x|
          map[x + drop.imag.i] = :moving
        }
        [left.real + drop.imag.i, right.real + drop.imag.i]
      end
    elsif map[below] == :moving
      []
    else
      raise
    end
  end.select { |drop| drop.imag <= max_y }
end

show.()

valid = map.select { |c,| range_y.include?(c.imag) }.values
p valid.count(&:watery?)
p valid.count(&:still?)
