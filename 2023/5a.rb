seeds, *maps = $<.read.split("\n\n")
seeds = seeds[/:(.+)/, 1].split.map { Integer _1 }

maps = maps.map do |map|
  map.lines[1..].map { |line|
    dest, src, len = line.split.map { Integer _1 }
    [(src...src+len), dest]
  }.sort_by { _1[0].begin }.to_h
end

p seeds.map { |seed|
  maps.reduce(seed) { |v, map|
    range = map.keys.find { |range| range === v }
    if range
      map[range] + (v - range.begin)
    else
      v
    end
  }
}.min
