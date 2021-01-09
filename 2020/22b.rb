decks = File.read('22.txt').strip.split("\n\n").map { |chunk|
  chunk.lines.then { |player, *cards| cards.map { |c| Integer(c) } }
}

def play_game(decks)
  p1, p2 = decks
  seen = {}

  until decks.any?(&:empty?)
    if seen[decks]
      return [1, decks]
    else
      seen[decks.map(&:dup)] = true
    end

    a, b = decks.map(&:shift)

    if p1.size >= a and p2.size >= b
      if play_game([p1.take(a), p2.take(b)])[0] == 1
        p1 << a << b
      else
        p2 << b << a
      end
    else
      if a > b
        p1 << a << b
      else
        p2 << b << a
      end
    end
  end

  winner = p1.empty? ? 2 : 1
  [winner, decks]
end

winner, decks = play_game(decks)
p decks.reject(&:empty?)[0].reverse.map.with_index(1) { |card, i| card * i }.sum
