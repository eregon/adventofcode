p1, p2 = decks = File.read('22.txt').strip.split("\n\n").map { |chunk|
  chunk.lines.then { |player, *cards| cards.map { Integer(_1) } }
}

until decks.any?(&:empty?)
  a, b = decks.map(&:shift)
  if a > b
    p1 << a << b
  else
    p2 << b << a
  end
end

p decks.reject(&:empty?)[0].reverse.map.with_index(1) { |card, i| card * i }.sum
