require 'set'

frequency = 0
history = Set.new

p File.readlines("1.txt", chomp: true).map(&:to_i).cycle.find { |df|
  frequency += df
  unless history.add?(frequency)
    break frequency
  end
}
