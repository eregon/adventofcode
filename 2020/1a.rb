p File.readlines('1.txt').map(&:to_i).combination(2).find { |a, b| a + b == 2020 }.reduce(:*)
