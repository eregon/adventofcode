Node = Struct.new(:value, :prev, :next) do
  def each
    node = self
    begin
      yield node
      node = node.next
    end until node.equal?(self)
  end

  def remove
    prev.next, self.next.prev = self.next, prev
  end

  Struct.remove_method :to_a

  def inspect
    value.inspect
  end
end

def max_score(players, marbles)
  score = Array.new(players, 0)
  player = 0
  value = 0
  gain = 0
  initial = Node.new(value)
  initial.next = initial.prev = initial

  current = initial

  marbles.times do
    value += 1
    player = (player + 1) % players

    if value % 23 == 0
      7.times { current = current.prev }
      gain = value + current.value
      score[player] += gain
      current.remove
      current = current.next
    else
      current = current.next
      node = Node.new(value, current, current.next)
      # Interestingly, this does not work:
      # current.next, current.next.prev = node, node
      # But this does:
      current.next.prev, current.next = node, node
      current = node
    end
  end

  score.max
end

p max_score(9, 25)
p max_score(10, 1618)
p max_score(30, 5807)
p max_score(419, 71052)
p max_score(419, 7105200)
