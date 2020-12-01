entries = File.readlines('1.txt').map { Integer(_1) }
p entries.combination(3).find { |a, b, c| a + b + c == 2020 }.reduce(:*)
