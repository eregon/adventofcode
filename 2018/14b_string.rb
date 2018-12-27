ending = '077201'
elf1 = 0
elf2 = 1
recipes = "37"

loop do
  a = recipes[elf1].to_i
  b = recipes[elf2].to_i

  recipes << (a + b).to_s

  elf1 = (elf1 + 1 + a) % recipes.size
  elf2 = (elf2 + 1 + b) % recipes.size

  break if recipes.end_with?(ending)
  break if recipes[-ending.size-1, ending.size] == ending

  p recipes.size if (recipes.size & 0xFFFF) == 0xFFFF
end

p recipes.index(ending)
