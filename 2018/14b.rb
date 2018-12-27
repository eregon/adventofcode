ENDING = '077201'.chars.map(&:to_i)
elves = [0, 1]
recipes = [3, 7]

# recipes[-ENDING.size..-1] == ENDING is too slow
eval <<-AOC
def check(recipes)
  #{ENDING.map.with_index { |d,i| "recipes[#{-ENDING.size+i}] == #{d}" }.join(' && ')}
end
AOC

def check(recipes)
  ENDING.each_with_index.all? { |d,i| recipes[-ENDING.size+i] == d }
end

def check(recipes)
  ENDING.each_with_index { |d,i| return false unless recipes[-ENDING.size+i] == d }
  true
end

loop do
  new_recipes = elves.sum { |elf| recipes[elf] }

  if new_recipes >= 10
    recipes << (new_recipes / 10)
    break if check(recipes)
    recipes << (new_recipes % 10)
    break if check(recipes)
  else
    recipes << new_recipes
    break if check(recipes)
  end

  elves.map! { |elf|
    (elf + 1 + recipes[elf]) % recipes.size
  }

  p recipes.size if (recipes.size & 0xFFFF) == 0xFFFF
end

p recipes.size - ENDING.size
