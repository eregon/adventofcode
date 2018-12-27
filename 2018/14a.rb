n = 77201

elves = [0, 1]
recipes = [3, 7]
limit = n + 10

until recipes.size >= limit
  recipes.concat elves.sum { |elf| recipes[elf] }.to_s.chars.map(&:to_i)

  elves.map! { |elf|
    (elf + 1 + recipes[elf]) % recipes.size
  }
end

puts recipes[n, 10].join
