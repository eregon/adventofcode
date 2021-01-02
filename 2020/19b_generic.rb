rules, messages = File.read('19.txt').split("\n\n")
rules = rules.lines.to_h { |line| line.chomp.split(': ', 2).then { [Integer(_1), _2] } }
rules[8] = '42 | 42 8'
rules[11] = '42 31 | 42 11 31'

regexps = Hash.new { |h, n|
  rule = rules.fetch(n)
  h[rule] = if /^"(?<c>.)"$/ =~ rule
    /#{Regexp.escape c}/
  else
    /(?<g#{n}>#{rule.split(' | ').map { |subrule|
      subrule.split.map { |part|
        part = Integer(part)
        if part == n
          "(?:\\g<g#{n}>)"
        else
          regexps[part]
        end
      }.join
    }.join('|')})/
  end
}

valid = /\A#{regexps[0]}\z/
p messages.lines.map(&:chomp).grep(valid).size
