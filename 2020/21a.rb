foods = File.readlines('21.txt', chomp: true).map { |line|
  line.split(' (contains ', 2).then { [_1.split.map(&:to_sym), _2.chomp(')').split(', ').map(&:to_sym)] }
}

per_allergen = Hash.new { |h,k| h[k] = [] }
foods.each { |ingredients, allergens|
  allergens.each { |allergen| per_allergen[allergen] << ingredients }
}
per_allergen = per_allergen.transform_values { _1.reduce(:&) }
all_ingredients = foods.map(&:first).reduce(:+)
p (all_ingredients - per_allergen.values.reduce(:|)).size
