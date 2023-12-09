moves, _, *routes = $<.readlines.map(&:chomp)
moves = moves.chars.map { |c| c == 'L' ? 0 : 1 }
routes = routes.to_h { |l| l.split(/ = \(|, |\)/).then { [_1.to_sym, [_2.to_sym, _3.to_sym]] } }

positions = routes.keys.grep(/A\z/)
p positions.map { |pos|
  moves_enum = moves.cycle
  Enumerator.produce(pos) { |cur|
    routes[cur][moves_enum.next]
  }.find_index { |cur| cur.end_with? 'Z' }
}.reduce(:lcm)
