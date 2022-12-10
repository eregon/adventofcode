require_relative 'lib'

instructions = File.readlines('10.txt', chomp: true)
x = 1
cycle = 1
x_values = [nil]

clock = -> {
  x_values[cycle] = x
  cycle += 1
}

instructions.each { |instruction|
  case instruction
  in /^noop$/
    clock.()
  in /^addx (-?\d+)$/
    clock.()
    clock.()
    x += Integer($1)
  end
}

p [20, 60, 100, 140, 180, 220].sum { x_values.fetch(_1) * _1 }
