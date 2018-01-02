input = File.read("24.txt")

components = input.lines.map { |line| line.chomp.split('/').map(&:to_i).sort }.sort

Node = Struct.new(:prev, :component, :last, :remaining, :score, :length)
root = Node.new(nil, nil, 0, components.dup.freeze, 0, 0)

def path(node)
  if prev = node.prev
    path(prev) << node
  else
    []
  end
end

def show(node)
  path = path(node)

  path.map { |n|
    c = n.component
    if n.prev.last == c[0]
      c
    else
      c.reverse
    end
  }
end

stack = [root]
all = []

while node = stack.pop
  all << node
  node.remaining.select { |c| c.include?(node.last) }.each { |c|
    remaining = node.remaining.dup
    remaining.delete_at remaining.index(c)
    neighbor = Node.new(
      node,
      c,
      c[0] == node.last ? c[1] : c[0],
      remaining.freeze,
      node.score + c.reduce(:+),
      node.length + 1)
    stack << neighbor
  }
end

puts "Part 1"
strongest = all.max_by(&:score)
p strongest.score
p show(strongest)

puts "\nPart 2"
max_length = all.max_by(&:length).length
longest = all.select { |n| n.length == max_length }.max_by(&:score)
p longest.score
p show(longest)
