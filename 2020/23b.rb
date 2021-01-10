class Node
  attr_reader :value
  attr_accessor :prev, :next

  def initialize(value)
    @value = value
  end

  def remove
    @prev.next, @next.prev = @next, @prev
    @prev, @next = nil, nil
    self
  end

  def insert_after(node)
    @prev, @next = node, node.next
    @prev.next, @next.prev = self, self
    self
  end

  def to_s
    value.to_s
  end
  alias_method :inspect, :to_s
end

class CyclicLinkedList
  attr_reader :current
  include Enumerable

  def initialize(values)
    @nodes = values.map { |v| Node.new(v) }
    (@nodes.each_cons(2).to_a + [[@nodes.last, @nodes.first]]).each { |a,b|
      a.next, b.prev = b, a
    }

    @current = @nodes.first
  end

  def advance!
    @current = @current.next
  end

  def each
    node = @current
    begin
      yield node
      node = node.next
    end while node != @current
    self
  end

  def to_s
    ary = to_a
    ary[0] = "(#{ary[0]})"
    ary.join(' ')
  end
  alias_method :inspect, :to_s
end

values = File.read('23.txt').strip.chars.map { |i| Integer(i) }
values += (values.max+1..1_000_000).to_a

min, max = values.minmax
list = CyclicLinkedList.new(values)

nodes = Array.new(1_000_001)
list.each { |node| nodes[node.value] = node }
nodes.freeze

10_000_000.times do
  pick = 3.times.map { list.current.next.remove }

  destination = list.current.value
  begin
    destination = destination == min ? max : destination - 1
  end while pick.any? { |node| node.value == destination }

  insert = nodes[destination]
  pick.each { |node|
    insert = node.insert_after(insert)
  }

  list.advance!
end

p [nodes[1].next, nodes[1].next.next].map(&:value).reduce(:*)
