moves, _, *routes = $<.readlines.map(&:chomp)
moves = moves.chars.map { |c| c == 'L' ? 0 : 1 }
routes = routes.to_h { |l| l.split(/ = \(|, |\)/).then { [_1.to_sym, [_2.to_sym, _3.to_sym]] } }

find_z = -> pos, start_step = 0 do
  steps = start_step
  begin
    dir = moves[steps % moves.size]
    pos = routes[pos][dir]
    steps += 1
  end until pos.end_with? 'Z'
  steps
end

positions = routes.keys.grep(/A\z/)
p positions.map { |pos|
  cycle = find_z[pos]
  raise unless find_z[pos, cycle] == cycle * 2
  cycle
}.reduce(:lcm)

__END__

# Too slow:
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
