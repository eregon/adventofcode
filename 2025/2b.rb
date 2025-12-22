ranges = $<.read.strip.split(",").flat_map {
  a, b = it.split('-')
  raise if a.to_i > b.to_i

  if a.size == b.size
    a.to_i..b.to_i
  else
    raise unless a.size + 1 == b.size
    [
      a.to_i..('9' * a.size).to_i,
      ('1' + '0' * a.size).to_i..b.to_i
    ]
  end
}
silly = Set.new

ranges.each { |range|
  a, b = range.begin, range.end
  as, bs = a.to_s, b.to_s
  s = as.size

  max = s / 2
  (1..max).each { |stride|
    if s % stride == 0
      repeats = s / stride
      a_first_part = as[0...stride]
      b_first_part = bs[0...stride]
      (a_first_part..b_first_part).each { |part|
        n = (part * repeats).to_i
        silly << n if range.cover? n
      }
    end
  }
}

p silly.sum
