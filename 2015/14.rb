Reindeer = Struct.new(:name, :fly, :duration, :rest, :position, :flying)
reindeers = []

STDIN.each_line { |line|
  # IDEA: auto convert to int with (\d+)
  # or auto build instance/hash? :)
  %r{^(?<name>\w+) can fly (?<fly>\d+) km/s for (?<duration>\d+) seconds, but then must rest for (?<sleep>\d+) seconds.$} =~ line
  raise line unless $&
  reindeers << Reindeer.new(name, Integer(fly), Integer(duration), Integer(sleep), 0, false)
}

# simulate
reindeers.each { |r|
  time = Integer(ARGV[0] || 2503)
  while time > 0
    if r.flying
      time -= r.rest
    else
      dur = [time, r.duration].min
      r.position += r.fly * dur
      time -= dur
    end
    r.flying = !r.flying
  end
}

puts reindeers
puts
p reindeers.max_by(&:position)
