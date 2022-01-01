require_relative 'lib'

lines = File.readlines('10.txt', chomp: true)

pairs = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>',
}
opening = pairs
closing = pairs.invert
values = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }

score = 0
lines.each { |line|
  nesting = []
  line.chars.each { |c|
    if opening[c]
      nesting << pairs[c]
    elsif closing[c]
      expected = nesting.pop
      if c != expected
        break score += values[c]
      end
    end
  }
}
p score
