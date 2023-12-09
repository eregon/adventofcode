seeds, *maps = $<.read.split("\n\n")
maps = maps.map do |map|
  map.lines[1..].map { |line|
    dest, src, len = line.split.map { Integer _1 }
    [(src...src+len), dest]
  }.sort_by { _1[0].begin }.to_h
end
pp maps

min = (2**31)-1
seeds = seeds[/:(.+)/, 1].split.map { Integer _1 }
seeds = seeds.each_slice(2).flat_map { |start,len|
  r = start...start+len
  p r
  r.each { |seed|
    result = maps.reduce(seed) { |v, map|
      range = map.keys.find { |range| range === v }
      if range
        map[range] + (v - range.begin)
      else
        v
      end
    }
    min = result if result < min
  }
}
p min
