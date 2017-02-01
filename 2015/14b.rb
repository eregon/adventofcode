Reindeer = Struct.new(:name, :fly, :duration, :rest, :position, :points) do
  def initialize(*)
    super
    @fiber = Fiber.new {
      loop {
        duration.times {
          self.position += fly
          Fiber.yield
        }
        rest.times {
          Fiber.yield
        }
      }
    }
  end

  def tick
    @fiber.resume
  end
end

n = Integer(ARGV[0] || 2503)

reindeers = STDIN.each_line.map { |line|
  %r{^(?<name>\w+) can fly (?<fly>\d+) km/s for (?<duration>\d+) seconds, but then must rest for (?<sleep>\d+) seconds.$} =~ line
  raise line unless $&
  Reindeer.new(name, Integer(fly), Integer(duration), Integer(sleep), 0, 0)
}

# simulate
n.times do
  reindeers.each { |r| r.tick }
  lead = reindeers.max_by(&:position)
  bests = reindeers.select { |r| r.position == lead.position }
  bests.each { |r| r.points += 1 }
end

puts reindeers
puts
p reindeers.max_by(&:points)
