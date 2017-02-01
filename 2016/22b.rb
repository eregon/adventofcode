
# lines = ARGF.readlines
lines = File.readlines("22.txt")

lines = lines.drop(2)

h = 28
w = 38

board = Array.new(h) { Array.new(w) }

nodes = lines.map { |line|
  x, y, size, used, avail, use = line.scan(/\d+/).map(&:to_i)
  board[y][x] = {x: x, y: y, size: size, used: used, avail: avail, use: use}
  {x: x, y: y, size: size, used: used, avail: avail, use: use}
}

viable = 0
nodes.combination(2) { |a,b|
  if a[:used] > 0 and a[:used] <= b[:avail]
    # p [a[:used], b[:avail]]
    p a => b if b[:x] != 34 || b[:y] != 26
    viable += 1
  end
  if b[:used] > 0 and b[:used] <= a[:avail]
    viable += 1
    p b => a if a[:x] != 34 || a[:y] != 26
  end
}
# p viable

used = nodes.map { |n| n[:used] }
avail = nodes.map { |n| n[:avail] }
size = nodes.map { |n| n[:size] }
p used.min(2)
# p used.max(30)
p avail.max(2)
p size.min(2)

can_move = avail.max
can_move = size.min

goal = board[0][w-1]
goal = [w-1, 0]

pos = [board[-2].index { |n| n[:used] == 0 }, h-2]

print = -> {
  board.each { |row|
    puts row.map { |node|
      if node[:used] == 0
        "S"
      elsif node[:x] == pos[0] and node[:y] == pos[1]
        "_"
      elsif node[:x] == goal[0] and node[:y] == goal[1]
        "G"
      elsif node[:used] <= can_move
        "."
      else
        "#"
      end
    }.join
  }
  puts
}

moves = 0

i = board[-4].index { |n| n[:used] > can_move }
(w-i-3).times {
  pos[0] -= 1
  moves += 1
}

print[]

until pos[1] == 0
  pos[1] -= 1
  moves += 1
end

print[]

until pos[0] == w-2
  pos[0] += 1
  moves += 1
end

print[]

until pos[0] == 0
  pos[0] += 1
  goal[0] -= 1
  moves += 1
  pos[1] += 1
  pos[0] -= 2
  pos[1] -= 1
  moves += 4
  # break
end

goal[0] -= 1
pos[0] += 1
moves += 1

print[]

p moves
