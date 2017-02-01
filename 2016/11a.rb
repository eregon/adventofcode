Gen = Struct.new(:i, :name) do
  alias to_s name
  alias inspect name
  alias :== :equal?
  alias :eql? :equal?
  def hash
    i.hash
  end
  def <=>(o)
    Mic === o ? 1 : i <=> o.i
  end
end
Mic = Struct.new(:i, :name) do
  alias to_s name
  alias inspect name
  alias :== :equal?
  alias :eql? :equal?
  def hash
    i.hash
  end
  def <=>(o)
    Gen === o ? -1 : i <=> o.i
  end
end

class Array
  def - o
    copy = dup
    o.each { |e| copy.delete(e) }
    copy
  end
end

can_be_at_same_level = -> items {
  micros, gens = items.partition { |e| Mic === e }
  return true if gens.empty?
  micros.all? { |m|
    gens.any? { |g| g.i == m.i }
  }
}

# p can_be_at_same_level.([Mic.new(1), Gen.new(1)])
# p can_be_at_same_level.([Mic.new(1), Gen.new(2)])
# p can_be_at_same_level.([Mic.new(1), Mic.new(2)])
# p can_be_at_same_level.([Gen.new(1), Gen.new(2)])
# p can_be_at_same_level.([Gen.new(1), Mic.new(1), Gen.new(2)])
# p can_be_at_same_level.([Mic.new(1)])

init_state = [
  [Mic.new(1, "HM"), Mic.new(2, "LM")],
  [Gen.new(1, "HG")],
  [Gen.new(2, "LG")],
  [],
].map(&:sort).freeze

init_state = [
  [Gen.new(1, "TG"), Mic.new(1, "TM"), Gen.new(2, "PG"), Gen.new(3, "SG")],
  [Mic.new(2, "PM"), Mic.new(3, "SM")],
  [Gen.new(4, "OG"), Mic.new(4, "OM"), Gen.new(5, "RG"), Mic.new(5, "RM")],
  []
]
init_state[0] += [
  Gen.new(6, "EG"), Mic.new(6, "EM"),
  Gen.new(7, "DG"), Mic.new(7, "DM")
]
init_state = init_state.map(&:sort).freeze

n_items = init_state.map(&:size).reduce(:+)

# [level, state]
init = [0, init_state].freeze
q = [init]
dists = Hash.new(Float::INFINITY)
dists[init] = 0
max_dist = 0

while current = q.shift
  level, state = current
  dist = dists[current]
  if dist > max_dist
    p dist
    max_dist = dist
  end
  # p current + [dist]
  items = state[level]
  if level == 3 and items.size == n_items
    p dist
    exit
  end
  moves = items.map { |e| [e] } + items.combination(2).to_a
  possible_moves = moves.select { |move|
    old_level = (items - move)
    can_be_at_same_level[old_level]
  }

  moves = possible_moves

  [-1,1].each { |dir|
    l = level+dir
    if l.between?(0,3)
      moves.each { |move|
        new_level = state[l] + move
        if can_be_at_same_level[new_level]
          new_state = state.dup
          new_state[level] = (items - move).sort
          new_state[l] = new_level.sort
          go = [l, new_state.freeze].freeze
          if dists[go] == Float::INFINITY
            dists[go] = dist+1
            q << go
          end
        end
      }
    end
  }
end
