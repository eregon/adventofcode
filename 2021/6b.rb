require_relative 'lib'

lanternfish = File.read('6.txt').chomp.split(',').map(&Integer)

days = 256

simulate = Hash.new { |h, state|
  h[state] = 1 + state.step(days, 7).sum { |day|
    simulate[day + 9]
  }
}

p lanternfish.sum { |day| simulate[day + 1] }
