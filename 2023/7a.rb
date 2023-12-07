hands = $<.map { |line|
  line.split.then { [_1.tr('AKQJT', 'EDCBA').chars, _2.to_i] }
}

p hands.sort_by { |hand, bid|
  tally = hand.tally
  max = tally.values.max
  type = case tally.size
  in 1
    7
  in 2
    if max == 4
      6
    else
      raise unless max == 3
      5
    end
  in 3
    if max == 3
      4
    else
      3
    end
  in 4
    2
  in 5
    1
  end
  [type, *hand]
}.map(&:last).zip(1..hands.size).sum { _1 * _2 }
