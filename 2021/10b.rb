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
values = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }

scores = []
lines.each { |line|
  nesting = []
  line.chars.each { |c|
    if opening[c]
      nesting << pairs[c]
    elsif closing[c]
      expected = nesting.pop
      if c != expected
        break nesting.clear
      end
    end
  }

  unless nesting.empty?
    scores << nesting.reverse.inject(0) { |score, close| score * 5 + values[close] }
  end
}
p scores.sort[scores.size / 2]
