moves, _, *routes = $<.readlines.map(&:chomp)
moves = moves.chars.map { |c| c == 'L' ? 0 : 1 }
routes = routes.to_h { |l| l.split(/ = \(|, |\)/).then { [_1.to_sym, [_2.to_sym, _3.to_sym]] } }

pp routes

positions = routes.keys.grep(/A\z/)
steps = 0
until positions.all?(/Z\z/)
  dir = moves[steps % moves.size]
  positions.map! do |pos|
    routes[pos][dir]
  end
  steps += 1

  if positions.any?(/Z\z/)
    p [steps, positions]
  end
end
p steps
