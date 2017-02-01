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

santa = Fiber.new(&give_gifts)

ARGF.read.chomp.each_char { |move|
  santa.resume(move)
}
p map.size
