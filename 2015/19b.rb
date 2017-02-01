require "set"

replacements = [
  ["e", "H"],
  ["e", "O"],
  ["H", "HO"],
  ["H", "OH"],
  ["O", "HH"]
]

goal = "HOHOHO".freeze

*replacements, _, goal = STDIN.read.strip.lines.map(&:chomp)
replacements.map! { |r|
  r.split(" => ")
}
goal.freeze

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
