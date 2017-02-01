changes = Hash.new { |h,k| h[k] = {} }

STDIN.each_line { |line|
  /^(?<sby>\w+) would (?<sign>gain|lose) (?<happiness>\d+) happiness units by sitting next to (?<neighbor>\w+).$/ =~ line
  raise line unless $&
  happiness = Integer(happiness)
  happiness = -happiness if sign == "lose"
  changes[sby][neighbor] = happiness
}

changes.keys.each { |person|
  changes["me"][person] = 0
  changes[person]["me"] = 0
}

people = changes.keys

TOTAL = -> perm {
  (perm + [perm[0]]).each_cons(2).inject(0) { |t,(a,b)|
    t + changes[a][b] + changes[b][a]
  }
}
arrangement = people.permutation.max_by(&TOTAL)

p arrangement
p TOTAL[arrangement]
