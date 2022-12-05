require_relative 'lib'

initial, moves = File.readlines('5.txt', chomp: true).slice_at("").exactly(2)

stacks = initial.map { |line|
  line.chars.map { _1 if _1 != " " }
}.transpose.map(&:reverse).select(&:first).map { |line|
  line.compact.drop(1)
}

moves.each { |move|
  /^move (\d+) from (\d+) to (\d+)$/ =~ move or raise move
  n, from, to = $~.captures.map(&Int)
  from -= 1
  to -= 1
  n.times { stacks[to] << stacks[from].pop }
}

puts stacks.map(&:last).join
