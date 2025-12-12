ranges = $<.read.strip.split(",").map {
  a, b = it.split('-')
  a = '1' + '0' * a.size if a.size.odd?  
  b = '9' * (b.size - 1) if b.size.odd?
  next if a.to_i > b.to_i
  raise unless a.size == b.size && a.size.even?
  [a, b, a.to_i..b.to_i]
}.compact

silly = []
ranges.each { |a, b, range|
  s = a.size
  (a[0...s/2]..b[0...s/2]).each { |half|
    n = (half * 2).to_i
    silly << n if range.cover? n
  }
}
p silly.sum
