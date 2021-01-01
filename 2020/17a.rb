require 'matrix'
require_relative 'lib'
using Refinements

class Cell
  attr_reader :pos, :state
  def initialize(pos, state)
    @pos = pos
    @state = state
  end

  def prepare
    @next_state = (@state ? (2..3) : (3..3)).cover?(neighbors.count(&:state))
  end

  def advance
    @state = @next_state
    @next_state = nil
  end

  def neighbors
    @neighbors ||= (-1..1).flat_map { |z|
      (-1..1).flat_map { |y|
        (-1..1).filter_map { |x|
          pos = @pos + Vector[x, y, z]
          BOARD[pos] unless pos == @pos
        }
      }
    }
  end

  def to_s
    @state ? '#' : '.'
  end
  alias_method :inspect, :to_s
end

BOARD = Hash.new { |h,pos| h[pos] = Cell.new(pos, false) }
def BOARD.show
  all_pos = keys
  puts
  all_pos.map { _1[2] }.minmax_range.each { |z|
    puts
    puts "z=#{z}"
    all_pos.map { _1[1] }.minmax_range.each { |y|
      puts all_pos.map { _1[0] }.minmax_range.map { |x|
        self[Vector[x,y,z]]
      }.join
    }
  }
end

initial = File.readlines('17.txt', chomp: true).map(&:chars)
initial.each_with_index { |row,y|
  row.each_with_index { |state,x|
    pos = Vector[x-row.size/2, y-initial.size/2, 0]
    BOARD[pos] = Cell.new(pos, state == '#')
  }
}
BOARD.values.each(&:neighbors)

6.times do
  cells = BOARD.values
  cells.each(&:prepare)
  cells.each(&:advance)
end

# BOARD.show

p BOARD.values.count(&:state)
