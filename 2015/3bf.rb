require 'set'
map = Set.new

give_gifts = -> move {
  map << (x, y = 0, 0)
  loop {
    case move
    when '<' then x -= 1
    when '>' then x += 1
    when '^' then y -= 1
    when 'v' then y += 1
    else raise move
    end
    map << [x, y]
    move = Fiber.yield
  }
}

n = Integer(ARGV[0] || 1)
santas = n.times.map { Fiber.new(&give_gifts) }

STDIN.read.chomp.each_char.each_slice(n) { |moves|
  santas.zip(moves) { |santa, move| santa.resume(move) }
}
p map.size
