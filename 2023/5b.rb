seeds, *maps = $<.read.split("\n\n")
seeds = seeds[/:(.+)/, 1].split.map { Integer _1 }
seeds = seeds.each_slice(2).flat_map { (_1.._1+_2-1) }.sort_by(&:begin)
pp seeds

reversed_maps = maps.map { |map|
  map.lines[1..].map { |line|
    dest, src, len = line.split.map { Integer _1 }
    [(dest...dest+len), src - dest]
  }.sort_by { _1[0].begin }.to_h
}.reverse

pp reversed_maps

p (0..).find { |n|
  p n if n % 100_000 == 0
  r = reversed_maps.reduce(n) { |v, map|
    range = map.keys.find { |range| range === v }
    if range
      map[range] + v
    else
      v
    end
  }
  seeds.any? { |seed| seed.include?(r) }
}
