require_relative 'lib'

ROCK = 1
PAPER = 2
SCISSORS = 3

BEATS = { ROCK => SCISSORS, PAPER => ROCK, SCISSORS => PAPER }
BEATEN_BY = BEATS.invert

MAPPING = {
  'A' => ROCK,
  'B' => PAPER,
  'C' => SCISSORS,
}

rounds = File.readlines('2.txt', chomp: true).map(&:split).map { [MAPPING[_1], _2] }
score = 0
rounds.each { |opponent, result|
  if result == 'X' # lose
    me = BEATS[opponent]
  elsif result == 'Y' # draw
    me = opponent
  else
    me = BEATEN_BY[opponent]
  end

  score += me
  if BEATS[me] == opponent
    score += 6
  elsif opponent == me
    score += 3
  end
}
p score
