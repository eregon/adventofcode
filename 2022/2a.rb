require_relative 'lib'

ROCK = 1
PAPER = 2
SCISSORS = 3

BEATS = { ROCK => SCISSORS, PAPER => ROCK, SCISSORS => PAPER }

MAPPING = {
  'A' => ROCK,
  'B' => PAPER,
  'C' => SCISSORS,
  'X' => ROCK,
  'Y' => PAPER,
  'Z' => SCISSORS,
}

rounds = File.readlines('2.txt', chomp: true).map(&:split).map { [MAPPING[_1], MAPPING[_2]] }
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
