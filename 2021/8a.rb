require_relative 'lib'

outputs = File.readlines('8.txt', chomp: true).map { _1.split(' | ').last.split }

segments_to_digit = {
  2 => 1,
  4 => 4,
  3 => 7,
  7 => 8,
}

p outputs.sum { |output| output.count { |v| segments_to_digit.include? v.size } }
