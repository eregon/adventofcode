# TODO

ranges = $<.read.strip.split(",").map {
  a, b = it.split('-')
  # p [a,b]
  # raise if (a.size - b.size).abs > 1
  if a.size.odd?
    a = '1' + '0' * a.size
  end
  if b.size.odd?
    b = '9' * (b.size - 1)
  end
  
  if a.to_i > b.to_i
    nil
  else
    raise [a,b].inspect unless a.size == b.size
    raise unless a.size.even?
    a.to_i..b.to_i
  end
}.compact
p ranges

silly = []

ranges.each { |range|
  a, b = range.begin, range.end
  as, bs = a.to_s, b.to_s
  s = as.size
  a_first_half = as[0...s/2]
  b_first_half = bs[0...s/2]
  p [a, b, a_first_half, b_first_half]
  (a_first_half..b_first_half).each { |half|
    n = "#{half}#{half}".to_i
    silly << n if range.cover? n
  }
}

p silly.sum
