require "set"

replacements = [
  ["H", "HO"],
  ["H", "OH"],
  ["O", "HH"]
]

str = "HOHOHO".freeze

*replacements, _, str = STDIN.read.strip.lines.map(&:chomp)
replacements.map! { |r|
  r.split(" => ")
}
str.freeze

all = Set.new
replacements.each { |(match, sub)|
  start = 0
  while i = str.index(match, start)
    copy = str.dup
    copy[i, match.size] = sub
    all << copy
    start = i + match.size
  end
}

#p all
p all.size
