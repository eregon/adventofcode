p ARGF.readlines.count { |line|
  line =~ /^(\w+)((?:\[\w+\]\w+)+)$/
  raise line unless $&
  ll = [$1]
  hh = []
  $2.split(/\[|\]/).drop(1).each_slice(2) { |h,l|
    hh << h
    ll << l
  }
  ll.flat_map { |l|
    l.scan(/(\w)(?=(\w)\1)/).select { |a,b| a != b }
  }.any? { |ab|
    bab = [ab[1], *ab].join
    hh.any? { |h| h.include? bab }
  }
}
