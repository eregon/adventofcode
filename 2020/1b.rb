p File.readlines('1.txt').map(&:to_i).combination(3).find { |a, b, c| a + b + c == 2020 }.reduce(:*)
