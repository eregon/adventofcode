input = File.read("4.txt")

p input.strip.lines.count { |line|
  words = line.split.map { |word| word.chars.sort.join }
  words.uniq == words
}
