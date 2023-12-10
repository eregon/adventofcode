seeds, *maps = $<.read.split("\n\n")
seeds = seeds[/:(.+)/, 1].split.map { Integer _1 }
seeds = seeds.each_slice(2).flat_map { (_1..._1+_2) }.sort_by(&:begin)

maps = maps.map do |map|
  map.lines[1..].map { |line|
    dest, src, len = line.split.map { Integer _1 }
    [(src...src+len), dest - src]
  }.sort_by { _1[0].begin }.to_h
end

ranges = seeds
maps.each { |map|
  cuts = map.keys.flat_map { [_1.begin, _1.end] }
  cuts.uniq!
  raise unless cuts.sort == cuts

  cuts.each { |cut|
    ranges.dup.each { |range|
      if range.include?(cut) and cut != range.begin and cut != range.end
        ranges.delete(range)
        ranges << (range.begin...cut) << (cut...range.end)
      end
    }
  }

  ranges.map! { |range|
    k = map.keys.find { |key| key.cover?(range) }
    if k
      offset = map[k]
      (range.begin + offset...range.end + offset)
    else
      range
    end
  }
}

p ranges.map(&:begin).min
