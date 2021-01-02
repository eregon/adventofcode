rules, messages = File.read('19.txt').split("\n\n")
rules = rules.lines.to_h { |line| line.chomp.split(': ', 2).then { [Integer(_1), _2] } }
regexps = Hash.new { |h, n|
  rule = rules.fetch(n)
  h[rule] = if /^"(?<c>.)"$/ =~ rule
    /#{Regexp.escape c}/
  else
    Regexp.union rule.split(' | ').map { |subrule|
      Regexp.new subrule.split.map { |part| regexps[Integer(part)] }.join
    }
  end
}

valid = /\A#{regexps[0]}\z/
p messages.lines.map(&:chomp).grep(valid).size
