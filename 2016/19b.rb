n = 5
n = 3_001_330

class Elf
  attr_accessor :prev, :next, :i
  def initialize(i)
    @i = i
  end

  def delete
    @next.prev = @prev
    @prev.next = @next
  end
end

circle = Array.new(n) { |i| Elf.new(i+1) }
circle.each_cons(2) { |a,b| a.next, b.prev = b, a }
circle.last.next, circle.first.prev = circle.first, circle.last

participants = n
prev = elf = circle.first
mid = circle[participants / 2]

while participants > 1
  prev = elf
  mid.delete
  mid = mid.next
  mid = mid.next if participants.odd?
  participants -= 1
  elf = elf.next
end

p prev.i
# p [n, (2*n-10) % n + 1, prev.i]
