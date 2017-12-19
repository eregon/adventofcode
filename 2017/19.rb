input = File.read("19.txt")
input2 = <<AOC
     |          
     |  +--+    
     A  |  C    
 F---|----E|--+ 
     |  |  |  D 
     +B-+  +--+ 

AOC

grid = input.chomp.lines.map { |line| line.chars.map { |c| c == ' ' ? nil : c } }
height = grid.size
width = grid.map(&:size).max

in_bounds = -> pos {
  pos.real.between?(0, width-1) and
  pos.imag.between?(0, height-1)
}
at = -> pos {
  if in_bounds.(pos)
    grid[pos.imag][pos.real]
  end
}

start = grid[0].index('|') + 0.i
pos = start
dir = 1i
steps = 1
path = []

NEIGHBORS = [-1i, 1, 1i, -1]

loop {
  cur = at.(pos)
  path << cur if ('A'..'Z').include?(cur)

  if cur == '|' or cur == '-' or ('A'..'Z').include?(cur)
    front = pos + dir
    if at.(front)
      pos = front
    else
      break
    end
  elsif cur == '+'
    turns = NEIGHBORS - [dir, -dir]
    possible = turns.select { |turn| at.(pos+turn) }
    raise unless possible.size == 1
    dir = possible.first
    pos += dir
  else
    raise cur
  end
  steps += 1
}

p path.join
p steps
