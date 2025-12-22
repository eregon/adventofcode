p $<.sum {
  d = it.chomp.chars.map(&:to_i)
  i = 0
  12.times.map { |nth|
    max = d[i..-(12 - nth)].max
    i += d[i..].index(max) + 1
    max
  }.join.to_i
}
