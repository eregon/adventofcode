p $<.readlines.sum { |line|
  winning, got = line.split(/[:|]/)[1..].map { |series| series.split.map { Integer(_1) } }
  winning_cards = got.count { |card| winning.include?(card) }
  winning_cards > 0 ? 2 ** (winning_cards-1) : 0
}
