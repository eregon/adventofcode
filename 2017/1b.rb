input = File.read("1.txt")
digits = input.strip.chars.map { |e| Integer(e) }

p digits.zip(digits.rotate(digits.size/2)).select { |a, b| a == b }.sum(&:first)
