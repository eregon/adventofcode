require "treetop"
require "pry"

replacements = [
  ["e", "H"],
  ["e", "O"],
  ["H", "HO"],
  ["H", "OH"],
  ["O", "HH"]
]

goal = "HOHOHO".freeze

module Arithmetic
  module Node# < Treetop::Runtime::SyntaxNode
  end
end

Treetop.load 'test'

def clean_tree(node)
  return if node.elements.nil?
  node.elements.dup.each { |e|
    if e.extension_modules.empty? || !(e.is_a? Arithmetic::Node)
      i = node.elements.index(e)
      node.elements[i..i] = Array(e.elements)
    end
  }
  node.elements.each { |e|
    clean_tree(e)
  }
end

tree = ArithmeticParser.new.parse("HO")
clean_tree(tree)
clean_tree(tree)

p tree
puts tree

binding.pry

# *replacements, _, goal = STDIN.read.strip.lines.map(&:chomp)
# replacements.map! { |r|
#   r.split(" => ")
# }
# goal.freeze

init = Set.new
init << "e".freeze

p (1..Float::INFINITY).each { |n|
  p n
  # p init
  all = Set.new
  init.each { |str|
    replacements.each { |(match, sub)|
      start = 0
      while i = str.index(match, start)
        copy = str.dup
        copy[i, match.size] = sub
        all << copy
        if copy == goal
          p n
          #p all
          exit
        end
        start = i + match.size
      end
    }
  }
  init = all.freeze
  p init.first
}
