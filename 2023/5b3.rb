# Incomplete

class Range
  def &(range)
    a, b = self.begin, self.end
    c, d = range.begin, range.end

    if cover?(range)
      range
    elsif range.cover?(self)
      self
    else
      todo
    end
  end

  def overlap?(range)
    self.include?(range.begin) or self.include?(range.end) or
      range.include?(self.begin) or range.include?(self.end)
  end

  def split(range)

  end
end

seeds, *maps = $<.read.split("\n\n")
seeds = seeds[/:(.+)/, 1].split.map { Integer _1 }
seeds = seeds.each_slice(2).flat_map { (_1.._1+_2-1) }.sort_by(&:begin)
seeds.combination(2).each { |a,b| raise if a.overlap?(b) }
pp seeds

maps = maps.map do |map|
  map.lines[1..].map { |line|
    dest, src, len = line.split.map { Integer _1 }
    [(src..src+len-1), dest - src]
  }.sort_by { _1[0].begin }.to_h
end

ranges = seeds.dup
maps.each { |map|
  puts
  p map: map

  to_map = ranges.dup
  mapped = []
  map.keys.each { |key|
    p key: key
    to_map.dup.each { |seed|
      case [seed.include?(key.begin), seed.include?(key.end)]
      in [true, true]
        ranges.delete(seed)
        ranges << (seed.begin..key.begin-1) << key << (key.end+1..seed.end)
      in [true, false]
        ranges.delete(seed)
        ranges << (seed.begin..key.begin) << (key.begin..seed.end)
      in [false, true]
        ranges.delete(seed)
        ranges << (seed.begin..key.end) << (key.end..seed.end)
      in [false, false]
        if key.cover?(seed)

        else
          # fully disjoint
        end
      end
    }
  }

  map.keys.each { |key|
    p key: key
    ranges.dup.each { |seed|
      case [seed.cover?(key.begin), seed.cover?(key.end)]
      in [true, true]
        ranges.delete(seed)
        ranges << (seed.begin..key.begin-1) << key << (key.end+1..seed.end)
      in [true, false]
        ranges.delete(seed)
        ranges << (seed.begin..key.begin) << (key.begin..seed.end)
      in [false, true]
        ranges.delete(seed)
        ranges << (seed.begin..key.end) << (key.end..seed.end)
      in [false, false]
        # OK
      end
    }
    p ranges
  }

  # lookup
  ranges = ranges.map { |seed|
    k = map.keys.find { |key| key.cover?(seed) }
    if k
      offset = map[k]
      (seed.begin + offset...seed.end + offset)
    else
      seed
    end
  }
  p ranges
}
p ranges.map(&:begin).min
