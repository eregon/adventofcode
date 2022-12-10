require_relative 'lib'
require 'set'

DIRECTIONS = { 'R' => 1, 'L' => -1, 'U' => 1i, 'D' => -1i }
DIAGONAL_MOVES = [1+1i, 1-1i, -1+1i, -1-1i]
VISITED = Set.new

steps = File.readlines('9.txt', chomp: true)

head = tail = 0i
VISITED << tail

HYPOT_1_1 = Math.hypot(1, 1)
HYPOT_1_2 = Math.hypot(1, 2)

steps.each do |line|
  dir, n = line.split.then { [DIRECTIONS.fetch(_1), Integer(_2)] }
  n.times do
    head += dir
    distance = (tail - head).abs
    case distance
    when 0, 1, HYPOT_1_1
    when 2
      tail += (head - tail) / 2
    when HYPOT_1_2
      tail += DIAGONAL_MOVES.min_by { |move| ((tail + move) - head).abs }
    else
      raise [head, tail, distance].inspect
    end

    VISITED << tail
  end
end

p VISITED.size
