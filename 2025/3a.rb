p $<.sum {
  d = it.chomp.chars
  a = d[..-2].max
  b = d[d.index(a)+1..].max
  (a+b).to_i
}
