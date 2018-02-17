require 'matrix'

input = File.read("20.txt")

Particle = Struct.new(:position, :velocity, :acceleration)

particles = input.strip.lines.map { |line|
  Particle.new *line.split(', ').map { |part|
    part =~ /<(-?\d+),(-?\d+),(-?\d+)>/
    Vector[*$~.captures.map(&:to_i)]
  }
}

left = Hash.new(0)
until (left[particles.size] += 1) == 1000
  collisions = {}
  destroyed = []

  particles.each { |particle|
    particle.position += particle.velocity += particle.acceleration
    if with = collisions[particle.position]
      destroyed << with << particle
    else
      collisions[particle.position] = particle
    end
  }
  destroyed.each { |particle| particles.delete(particle) }
end

p particles.size
