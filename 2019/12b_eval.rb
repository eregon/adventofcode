require 'matrix'

Moon = Struct.new(:name, :pos, :vel) do
  def energy
    pos.to_a.sum(&:abs) * vel.to_a.sum(&:abs)
  end
end

input = File.readlines('12.txt')
names = %i[Io Europa Ganymede Callisto]
dimensions = 3

moons = input.zip(names).map { |line, name|
  pos = Vector[*line.scan(/-?\d+/).map(&:to_i)]
  Moon.new(name[0], pos, Vector.zero(dimensions))
}

ORIGINALS = Marshal.load(Marshal.dump(moons))
INDICIES = ORIGINALS.each_index.to_a.freeze

eval <<RUBY
def simulate(dim)
  orig_positions = ORIGINALS.map { |moon| moon.pos[dim] }.freeze
  orig_velocities = ORIGINALS.map { |moon| moon.vel[dim] }.freeze
  positions = orig_positions.dup
  velocities = orig_velocities.dup

  steps = 0
  begin
    #{INDICIES.combination(2).map { |a,b|
      "cmp = positions[#{a}] <=> positions[#{b}]
      velocities[#{a}] -= cmp
      velocities[#{b}] += cmp"
    }.join("\n")}

    #{INDICIES.map { |i| "positions[#{i}] += velocities[#{i}]" }.join("\n")}

    steps += 1
  end until positions == orig_positions and velocities == orig_velocities

  steps
end
RUBY

p dimensions.times.map { |dim| simulate(dim) }.reduce(:lcm)
