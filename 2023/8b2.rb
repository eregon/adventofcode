moves, _, *routes = $<.readlines.map(&:chomp)
routes = routes.to_h { |l| l.split(/ = \(|, |\)/).then { [_1, [_2, _3]] } }

pp routes

# Too slow :(
enums = routes.keys.grep(/A$/).map do |start|
  local_moves = moves.chars.cycle
  Enumerator.produce(start) { |pos|
    routes[pos][local_moves.next == 'L' ? 0 : 1]
  }
end

p enums.first.lazy.zip(*enums[1..]).find_index { |pos| pos.all?(/Z$/) }
