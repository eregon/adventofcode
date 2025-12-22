ranges = $<.read.strip.split(",").flat_map {
  a, b = it.split('-')
  raise if a.to_i > b.to_i

  if a.size == b.size
    a..b
  else
    raise unless a.size + 1 == b.size
    [
      a..('9' * a.size),
      ('1' + '0' * a.size)..b
    ]
  end
}

silly = Set.new
ranges.each { |range|
  a, b = range.begin, range.end
  s = a.size

  (1..s/2).each { |stride|
    if s % stride == 0
      repeats = s / stride
      (a[0...stride]..b[0...stride]).each { |part|
        n = part * repeats
        silly << n.to_i if range.cover? n
      }
    end
  }
}

p silly.sum
