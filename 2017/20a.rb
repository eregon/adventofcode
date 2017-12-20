require 'matrix'

input = File.read("20.txt")

Particle = Struct.new(:position, :velocity, :acceleration)

particles = input.strip.lines.map { |line|
  Particle.new *line.split(', ').map { |part|
    part =~ /<(-?\d+),(-?\d+),(-?\d+)>/
    Vector[*$~.captures.map(&:to_i)]
  }
}

def distance(particle)
  particle.position.to_a.map(&:abs).reduce(:+)
end

loop do
  particles.each { |particle|
    particle.position += particle.velocity += particle.acceleration
  }
  closer = particles.min_by { |particle| distance(particle) }
  p [particles.index(closer), closer.position]
end
