input = File.read("7.txt")

data = input.strip.lines.map { |line|
  case line
  when /^(\w+) \((\d+)\)$/
    [$1, $2.to_i, []]
  when /^(\w+) \((\d+)\) -> (.+)$/
    [$1, $2.to_i, $3.split(", ")]
  else
    raise line
  end
}

weights = {}
children = {}
below = {}
data.each { |prog, weight, holds|
  weights[prog] = weight
  children[prog] = holds
  holds.each { |e| below[e] = prog }
}

bottom = data.first[0]
while b = below[bottom]
  bottom = b
end
p bottom

cumulative_weights = Hash.new { |h,prog|
  h[prog] = weights[prog] + children[prog].sum { |e| cumulative_weights[e] }
}

search_unbalanced = -> prog {
  ww = children[prog].map { |e| cumulative_weights[e] }
  unless ww.all? { |w| w == ww.first }
    different = ww.find { |w| ww.count(w) == 1 }
    others = (ww-[different]).uniq.first
    unbalanced = children[prog].find { |e| cumulative_weights[e] == different }
    p weights[unbalanced] + (others - different)
  end
  children[prog].each { |child| search_unbalanced[child] }
}
search_unbalanced[bottom]
