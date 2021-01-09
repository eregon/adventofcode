module Kernel
  def then
    yield self
  end
end

module Enumerable
  def filter_map
    array = []
    each { |e|
      r = yield(e)
      array << r if r
    }
    array
  end
end

class Array
  def sum
    reduce(0, :+)
  end
end

class Module
  # To support refine some_module
  def refine(mod, &block)
    mod.class_exec(&block)
  end
end
