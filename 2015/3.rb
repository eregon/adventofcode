require 'set'
map = Set.new
x, y = 0, 0
map << [x,y]
ARGF.read.chomp.each_char { |c|
  case c
  when '<'
    x -= 1
  when '>'
    x += 1
  when '^'
    y -= 1
  when 'v'
    y += 1
  else
    raise c
  end
  map << [x,y]
}
p map.size
