equations = $<.map { it.split(/\D+/).map(&:to_i).then { |res, *operands| [res, operands] } }

p equations.select { |result, operands|
  %i[+ *].repeated_permutation(operands.size-1).any? { |operators|
    operands.inject { |r, n| r.send(operators.shift, n) } == result
  }
}.sum(&:first)