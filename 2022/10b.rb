require_relative 'lib'

instructions = File.readlines('10.txt', chomp: true)
x = 1
crt = 0
cycle = 1
screen = Array.new(240, false)

clock = -> {
  screen[crt] = true if (x - (crt % 40)).abs <= 1
  cycle += 1
  crt += 1
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

puts screen.each_slice(40).map { |row| row.map { _1 ? '#' : '.' }.join }
