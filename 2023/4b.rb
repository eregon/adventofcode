lines = $<.readlines
cards = [1] * lines.size
lines.each_with_index { |line, card|
  winning, got = line.split(/[:|]/)[1..].map { |series| series.split.map { Integer(_1) } }
  win = got.count { winning.include?(_1) }
  i = card
  win.times { cards[i += 1] += cards[card] }
}
p cards.sum
