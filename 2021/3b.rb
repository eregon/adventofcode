data = File.readlines('3.txt', chomp: true)

def rating(numbers, i, criteria)
  return numbers[0] if numbers.size == 1
  zeros, ones = numbers.map { _1[i] }.tally.values_at('0', '1')
  keep = criteria[zeros <=> ones]
  numbers = numbers.select { _1[i] == keep }
  rating(numbers, i+1, criteria)
end

oxygen = rating(data, 0, { -1 => '1', 0 => '1', 1 => '0' })
co2 = rating(data, 0, { -1 => '0', 0 => '0', 1 => '1' })

p oxygen.to_i(2) * co2.to_i(2)
