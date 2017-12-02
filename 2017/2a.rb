input = File.read("2.txt")
rows = input.strip.lines.map { |line| line.split.map(&:to_i) }

p rows.map { |row| row.minmax.reduce(:-).abs }.sum
