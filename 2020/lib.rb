# Usage:
# require_relative 'lib'
# using Refinements

module Refinements
  refine String do
    remove_method :to_i if self == String
    def to_i
      Integer(self)
    end
  end

  refine TrueClass do
    def to_i
      1
    end
  end

  refine FalseClass do
    def to_i
      0
    end
  end

  refine Kernel do
    def deep_copy
      Marshal.load(Marshal.dump(self))
    end
  end

  refine Complex do
    def round
      Complex(*rect.map(&:round))
    end
  end

  refine Array do
    def minmax_range
      Range.new(*minmax)
    end

    def rotate_right
      transpose.map(&:reverse)
    end

    def flip_horizontally
      map(&:reverse)
    end

    def flip_vertically
      reverse
    end
  end
end

class RepeatingArray
  def initialize(array)
    @array = array
  end

  def index(e)
    @array.index(e)
  end

  def [](i)
    @array[i % @array.size]
  end
end

class Matrix2D
  include Enumerable

  attr_reader :rows

  def initialize(rows)
    @rows = rows
  end

  def [](i, j = (_, i = i.rect)[0])
    j >= 0 and i >= 0 and row = @rows[i] and row[j]
  end

  def each(&block)
    @rows.each { |row| row.each(&block) }
  end

  def map
    Matrix2D.new @rows.map.with_index { |row, i|
      row.map.with_index { |cell, j|
        yield cell, i.i+j
      }
    }
  end

  def ==(other)
    @rows == other.rows
  end

  def dup
    Matrix2D.new @rows.map(&:dup)
  end

  def to_s
    @rows.map(&:join).join("\n") + "\n" * 2
  end
end
