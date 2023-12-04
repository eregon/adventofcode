p $<.readlines.sum { |line|
  winning, got = line.split(/[:|]/)[1..].map { |series| series.split.map { Integer(_1) } }
  winning_cards = got.count { |card| winning.include?(card) }
  1 << winning_cards-1
}
