module Enumerable
  def sum(init = 0)
    if block_given?
      inject(init) { |sum, e| sum + yield(e) }
    else
      inject(init, :+)
    end
  end unless method_defined? :sum
end

module Kernel
  def yield_self
    if block_given?
      yield self
    else
      [self].to_enum { 1 }
    end
  end unless method_defined? :yield_self
end
