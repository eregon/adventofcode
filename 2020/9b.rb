numbers = File.readlines('9.txt').map { Integer(_1) }

N = numbers.each_cons(25+1).find { |*prev, n|
  break n if prev.combination(2).none? { |a,b| a + b == n }
}

numbers.each_with_index do |sum, from, to = from|
  sum += numbers[to += 1] while sum < N
  break p numbers[from..to].minmax.sum if sum == N
end
