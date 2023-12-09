moves, _, *routes = $<.readlines(chomp: true)
moves = moves.chars.cycle
routes = routes.to_h { |l| l.split(/ = \(|, |\)/).then { [_1, [_2, _3]] } }

p Enumerator.produce("AAA") { |pos|
  # routes[pos][moves.next == 'L' ? 0 : 1]
  routes[pos][moves.next.ord / ?R.ord]
}.find_index { |pos| pos == "ZZZ" }
