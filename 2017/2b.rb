input = File.read("2.txt")
rows = input.strip.lines.map { |line| line.split.map(&:to_i) }

p rows.map { |row|
  row.sort.reverse.combination(2).select { |a,b| a % b == 0 }.first.reduce(:/)
}.sum
