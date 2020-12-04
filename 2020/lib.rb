# Usage:
# require_relative 'lib'
# using Refinements

module Refinements
  refine String do
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
end