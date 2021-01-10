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

min, max = values.minmax
list = CyclicLinkedList.new(values)

100.times do
  pick = 3.times.map { list.current.next.remove }

  destination = list.current.value
  begin
    destination = destination == min ? max : destination - 1
  end while pick.any? { |node| node.value == destination }

  insert = list.find { |node| node.value == destination }
  pick.each { |node|
    insert = node.insert_after(insert)
  }

  list.advance!
end

list.advance! until list.current.value == 1
puts list.drop(1).join
