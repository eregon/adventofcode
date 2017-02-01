Ingredient = Struct.new(:name, :capacity, :durability, :flavor, :texture, :calories)
PROPS = [:capacity, :durability, :flavor, :texture]

ingredients = STDIN.each_line.map { |line|
  # Sugar: capacity 0, durability 0, flavor -2, texture 2, calories 1
  n = /(-?\d+)/
  /^(\w+): capacity #{n}, durability #{n}, flavor #{n}, texture #{n}, calories #{n}$/ =~ line
  raise line unless $&
  Ingredient.new($1, *$~.values_at(2..-1).map(&:to_i))
}

best = nil
best_score = 0

def score(comb)
  PROPS.map { |prop|
    prop
    [comb.inject(0) { |s, (qty, ing)|
      s + ing[prop] * qty
    }, 0].max
  }.reduce(:*)
end

work = -> left, comb, i {
  if i == ingredients.size
    score = score(comb)
    if score > best_score
      best_score = score
      best = comb
    end
  else
    ing = ingredients[i]
    (0..left).each { |qty|
      new_comb = comb + [[qty, ing]]
      work.call(left - qty, new_comb, i+1)
    }
  end
}

puts ingredients
puts

# p score([[44, ingredients[0]], [56, ingredients[1]]])

work.call(100, [], 0)
p best.map { |qty,ing| [qty, ing.name] }
p score(best)
