require_relative 'lib'

lines = File.readlines('8.txt', chomp: true).map { |line| line.split(' | ').map { _1.split } }

segments_to_digit = {
  'abcefg' => 0,
  'cf' => 1,
  'acdeg' => 2,
  'acdfg' => 3,
  'bcdf' => 4,
  'abdfg' => 5,
  'abdefg' => 6,
  'acf' => 7,
  'abcdefg' => 8,
  'abcdfg' => 9,
}

def reduce(possibilities)
  possibilities.values.select { _1.size == 1 }.each { |found|
    possibilities.each { |k, v| v.delete(*found) unless v == found }
  }

  possibilities.values.group_by(&:itself).select { |k, v| k.size == 2 and v.size == 2 }.each_key { |double|
    possibilities.each { |k, v| double.each { v.delete(_1) } unless v == double }
  }
end

p lines.sum { |inputs, outputs|
  possibilities = {}
  ('a'..'g').each { |l| possibilities[l] = ('a'..'g').to_a }

  one = inputs.find { _1.size == 2 }
  cf1, cf2 = one.chars
  [cf1, cf2].each { |c| possibilities[c] = %w[c f] }

  seven = inputs.find { _1.size == 3 }
  a = (seven.chars - one.chars)[0]
  possibilities[a] = %w[a]

  four = inputs.find { _1.size == 4 }
  bd1, bd2 = four.chars - one.chars
  [bd1, bd2].each { |c| possibilities[c] = %w[b d] }

  zero = inputs.find { _1.size == 6 and _1.count("#{bd1}#{bd2}") == 1 }
  d = zero.include?(bd1) ? bd2 : bd1
  possibilities[d] = %w[d]

  six = inputs.find { _1.size == 6 and _1.count("#{cf1}#{cf2}") == 1 }
  c = six.include?(cf1) ? cf2 : cf1
  possibilities[c] = %w[c]

  nine = inputs.find { _1.size == 6 and _1.count("#{cf1}#{cf2}") == 2 and _1 != zero }
  e = (('a'..'g').to_a - nine.chars)[0]
  possibilities[e] = %w[e]

  reduce(possibilities) until possibilities.values.all? { _1.size == 1 }

  tr = [possibilities.keys.join, possibilities.values.join]
  outputs.map { |output| segments_to_digit.fetch(output.tr(*tr).chars.sort.join) }.join.to_i
}
