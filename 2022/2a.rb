require_relative 'lib'

ALL = (ROCK, PAPER, SCISSORS = 1, 2, 3)
BEATS = ALL.zip(ALL.rotate(-1)).to_h

rounds = File.readlines('2.txt', chomp: true).map(&:split).map {
  [_1.ord - 'A'.ord + 1, _2.ord - 'X'.ord + 1]
}
score = 0
rounds.each { |opponent, me|
  score += me
  if BEATS[me] == opponent
    score += 6
  elsif opponent == me
    score += 3
  end
}
p score
