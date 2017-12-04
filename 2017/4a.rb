input = File.read("4.txt")

p input.strip.lines.count { |line|
  words = line.split
  words.uniq == words
}
