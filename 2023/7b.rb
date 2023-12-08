hands = $<.map { |line|
  line.split.then { [_1.tr('AKQTJ', 'DCBA1'), _2.to_i] }
}

p hands.sort_by { |hand, bid|
  type = [*'2'..'9', *'A'..'D'].map { |v|
    tally = hand.tr('1',v).chars.tally
    max = tally.values.max
    case tally.size
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
  }.max
  [type, *hand]
}.map(&:last).zip(1..hands.size).sum { _1 * _2 }
