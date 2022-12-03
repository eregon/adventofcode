require_relative 'lib'

p File.readlines('3.txt', chomp: true).each_slice(3).sum { |lines|
  common = lines.map(&:chars).reduce(:&).single
  if common.between?('a', 'z')
    common.ord - 'a'.ord + 1
  elsif common.between?('A', 'Z')
    common.ord - 'A'.ord + 27
  else
    raise common
  end
}
