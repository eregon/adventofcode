rules, updates = $<.read.split("\n\n")

rules = rules.lines.map { |rule| rule.split('|').map(&:to_i) }
  .group_by { |a,b| a }.transform_values { it.map(&:last) }

updates = updates.lines.map { |update| update.split(',').map(&:to_i) }

p updates.select { |pages|
  pages.each_with_index.all? { |page,i|
    (after = rules[page]).nil? or after.all? { |a|
      j = pages.index(a)
      !j || j > i
    }
  }
}.sum { it[it.size/2] }
