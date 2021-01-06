foods = File.readlines('21.txt', chomp: true).map { |line|
  line.split(' (contains ', 2).then { [_1.split.map(&:to_sym), _2.chomp(')').split(', ').map(&:to_sym)] }
}

per_allergen = Hash.new { |h,k| h[k] = [] }
foods.each { |ingredients, allergens|
  allergens.each { |allergen| per_allergen[allergen] << ingredients }
}
per_allergen = per_allergen.transform_values { _1.reduce(:&) }

known = {}
until per_allergen.empty?
  per_allergen.select { |allergen, ingredients|
    ingredients.size == 1
  }.each { |allergen, (ingredient, *)|
    known[ingredient] = allergen
    per_allergen.delete(allergen)
    per_allergen.each_value { _1.delete(ingredient) }
  }
end
puts known.sort_by(&:last).map(&:first).join(',')
