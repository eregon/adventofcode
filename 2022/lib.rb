def Integer.to_proc
  -> v { Integer(v) }
end
Int = Integer

class Array
  def single
    raise inspect unless size == 1
    first
  end

  def exactly(n)
    raise inspect unless size == n
    self
  end
end

module Enumerable
  def slice_at(matcher, &block)
    block ||= -> e { matcher === e }

    slices = [slice = []]
    each do |e|
      if block.call(e)
        slices << slice = []
      else
        slice << e
      end
    end
    slices
  end
end

class ArrayIterator
  def initialize(array)
    @array = array
    @i = 0
  end

  def peek
    @array[@i]
  end

  def next?
    @i < @array.size
  end

  def next
    @array[@i].tap { @i += 1 }
  end
end
