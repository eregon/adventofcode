require_relative 'lib'

input = File.readlines('6.txt', chomp: true).single
# input = STDIN.readlines(chomp: true).single

p input.chars.each_cons(14).find_index { |chars|
  chars.uniq == chars
} + 14
