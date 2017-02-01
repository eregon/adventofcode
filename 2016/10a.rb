lines = File.readlines("10.txt").map(&:chomp)

inputs, moves = lines.partition { |line| line.start_with? 'value ' }

class Fiber
  alias call resume
  alias :[] :instance_variable_get
  alias :[]= :instance_variable_set
end

outputs = Hash.new { |h,k| h[k] = [] }
actions = {}
bots = Hash.new { |h,k|
  h[k] = f = Fiber.new { |in1|
    in2 = Fiber.yield
    min, max = [in1, in2].minmax
    if min == 17 and max == 61
      p [:bot, k]
    end
    min_to, max_to = f[:@action]
    min_to.call(min)
    max_to.call(max)
  }
}

moves.each { |move|
  move =~ /^bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)$/
  raise move unless $~
  bot, low, high = Integer($1), Integer($3), Integer($5)
  bot = bots[bot]
  raise if bot[:@action]
  bot[:@action] = [
    $2 == "output" ? outputs[low].method(:<<)  : bots[low],
    $4 == "output" ? outputs[high].method(:<<) : bots[high]
  ]
}

inputs.each { |input|
  raise input unless input =~ /^value (\d+) goes to bot (\d+)$/
  value, bot = Integer($1), Integer($2)
  bots[bot].call(value)
}

p outputs
p (0..2).map { |i| outputs[i].first }.reduce(:*)
