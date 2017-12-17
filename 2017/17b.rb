n = Integer(ARGV[0] || 50_000_000)
steps = 314

# idx is the node value, ary[idx] is next node
nodes = Array.new(n, 0)
nodes[0] = 0
pos = 0

n.times do |i|
  p i if i % 1_000_000 == 0
  steps.times { pos = nodes[pos] }
  nodes[i+1] = nodes[pos]
  nodes[pos] = i+1
  pos = i+1
end

p nodes[0]
