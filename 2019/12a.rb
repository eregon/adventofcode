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

1000.times do |step|
  moons.combination(2) { |a,b|
    dimensions.times { |dim|
      cmp = a.pos[dim] <=> b.pos[dim]
      a.vel[dim] -= cmp
      b.vel[dim] += cmp
    }
  }

  moons.each { |moon| moon.pos += moon.vel }
end

p moons.sum(&:energy)
