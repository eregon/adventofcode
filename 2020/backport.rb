raise unless RUBY_VERSION == '2.0.0'

require 'backports/2.7'

module Kernel
  alias_method :_Integer, :Integer
  def Integer(n, base = 0, exception: true)
    if exception
      _Integer(n, base)
    else
      _Integer(n, base) rescue nil
    end
  end
end

module Enumerable
  alias_method :_each_with_index, :each_with_index
  def each_with_index(&block)
    if block_given?
      _each_with_index(&block)
    else
      _each_with_index.to_a
    end
  end
end

class Enumerator
  alias_method :_with_index, :with_index
  def with_index(start = 0, &block)
    if block_given?
      _with_index(start, &block)
    else
      _with_index(start).to_a
    end
  end
end

class Integer
  def digits(base = 10)
    raise if base > 10
    to_s(base).reverse.chars.map(&:to_i)
  end
end

class Module
  # To support refine some_module
  alias_method :_refine, :refine
  def refine(mod, &block)
    mod.class_exec(&block)
  end

  public :prepend
end

class << IO
  alias_method :_readlines, :readlines
  def readlines(*args, chomp: false)
    lines = _readlines(*args)
    lines.each(&:chomp!) if chomp
    lines
  end
end

class Method
  alias_method :===, :call
end

module RubyNext
  module Core
  end
end

require_relative 'deconstruct'
