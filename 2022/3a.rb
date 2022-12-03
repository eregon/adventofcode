require_relative 'lib'

p File.readlines('3.txt', chomp: true).sum { |line|
  a, b = line[0...line.size/2], line[line.size/2..-1]
  common = (a.chars & b.chars).single
  if common.between?('a', 'z')
    common.ord - 'a'.ord + 1
  elsif common.between?('A', 'Z')
    common.ord - 'A'.ord + 27
  else
    raise common
  end
}
