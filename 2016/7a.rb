ABBA = -> s { s.scan(/(\w)(\w)\2\1/).any? { |a,b| a != b } }
p ARGF.readlines.count { |line|
  line =~ /^(\w+)((?:\[\w+\]\w+)+)$/
  raise line unless $&
  ll = [$1]
  hh = []
  $2.split(/\[|\]/).drop(1).each_slice(2) { |h,l|
    hh << h
    ll << l
  }
  ll.any?(&ABBA) and hh.none?(&ABBA)
}
