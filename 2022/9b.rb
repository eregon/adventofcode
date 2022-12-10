require_relative 'lib'
require 'set'

DIRECTIONS = { 'R' => 1, 'L' => -1, 'U' => 1i, 'D' => -1i }
DIAGONAL_MOVES = [1+1i, 1-1i, -1+1i, -1-1i]
VISITED = Set.new

steps = File.readlines('9.txt', chomp: true)

head = 0i
TAILS = 9.times.map { 0i }
def tail
  TAILS.last
end

HYPOT_1_1 = Math.hypot(1, 1)
HYPOT_1_2 = Math.hypot(1, 2)
HYPOT_2_2 = Math.hypot(2, 2)

steps.each do |line|
  dir, n = line.split.then { [DIRECTIONS.fetch(_1), Integer(_2)] }
  n.times do
    head += dir
    prev = head
    TAILS.each_with_index { |tail, i|
      distance = (tail - prev).abs
      case distance
      when 0, 1, HYPOT_1_1
      when 2, HYPOT_2_2
        tail += (prev - tail) / 2
      when HYPOT_1_2
        tail += DIAGONAL_MOVES.min_by { |move| ((tail + move) - prev).abs }
      else
        p [head, *TAILS]
        raise [i, prev, tail, distance].inspect
      end

      prev = TAILS[i] = tail
      # p head, TAILS
    }

    VISITED << TAILS.last
  end
end

p VISITED.size
