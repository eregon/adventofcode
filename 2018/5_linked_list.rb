polymer = File.read("5.txt").chomp.chars.freeze

def react?(a, b)
  a.downcase == b.downcase && a != b
end

Node = Struct.new(:value, :prev, :next) do
  def each
    node = self
    while node
      yield node
      node = node.next
    end
  end
end

def react(polymer)
  polymer = polymer.map { |char| Node.new(char) }
  polymer.each_cons(2) { |a,b| (b.prev = a).next = b }
  cur = polymer.first

  while cur and collapse = cur.find { |node| node.next && react?(node.value, node.next.value) }
    before, after = collapse.prev, collapse.next.next
    after&.prev = before
    before&.next = after
    cur = before || after
  end
  return 0 unless cur

  first = cur
  first = first.prev while first.prev
  first.count
end

p react(polymer)

p polymer.map(&:downcase).uniq.sort.map { |type|
  without = polymer.dup
  without.delete(type)
  without.delete(type.upcase)
  react(without)
}.min
