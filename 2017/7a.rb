input = File.read("7.txt")

data = input.strip.lines.map { |line|
  case line
  when /^(\w+) \(\d+\)$/
    [$1, []]
  when /^(\w+) \(\d+\) -> (.+)$/
    [$1, $2.split(", ")]
  else
    raise line
  end
}

below = {}
data.each { |prog, holds|
  holds.each { |e| below[e] = prog }
}

bottom = data.first[0]
while b = below[bottom]
  bottom = b
end
p bottom
