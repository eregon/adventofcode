require 'set'
map = Set.new
robot = [0, 0]
santa = [0, 0]
map << santa.dup.freeze
ARGF.read.chomp.each_char.each_slice(2) { |s,r|
  [santa, robot].zip([s,r]) { |i,c|
    case c
    when '<'
      i[0] -= 1
    when '>'
      i[0] += 1
    when '^'
      i[1] -= 1
    when 'v'
      i[1] += 1
    else
      raise c
    end
    map << i.dup.freeze
  }
  #p({santa: santa, robot: robot})
}
p map.size
