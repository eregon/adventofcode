entries = File.readlines('1.txt').map { Integer(_1) }
p entries.combination(2).find { |a, b| a + b == 2020 }.reduce(:*)
