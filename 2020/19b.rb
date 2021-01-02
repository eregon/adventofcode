rules, messages = File.read('19.txt').split("\n\n")
rules = rules.lines.to_h { |line| line.chomp.split(': ', 2).then { [Integer(_1), _2] } }
can_expand = false
regexps = Hash.new { |h, n|
  raise "Must not expand #{n} yet" if !can_expand and (n == 8 or n == 11)
  rule = rules.fetch(n)
  h[rule] = if /^"(?<c>.)"$/ =~ rule
    /#{Regexp.escape c}/
  else
    Regexp.union rule.split(' | ').map { |subrule|
      Regexp.new subrule.split.map { |part| regexps[Integer(part)] }.join
    }
  end
}

# 8: 42 | 42 8
regexps[8] = /#{regexps[42]}+/
# 11: 42 31 | 42 11 31
regexps[11] = /(?<eleven>#{regexps[42]}(?:\g<eleven>)?#{regexps[31]})/

can_expand = true
valid = /\A#{regexps[0]}\z/
p messages.lines.map(&:chomp).grep(valid).size
