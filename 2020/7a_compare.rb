require_relative 'lib'
using Refinements

COLOR = /\w+ \w+/
N_BAGS = /(\d+) (#{COLOR}) bags?/

contain = File.readlines('7.txt', chomp: true).to_h { |line|
  case line
  when /^(?<color>#{COLOR}) bags contain no other bags\.$/
    [$~[:color], []]
  when /^(?<color>#{COLOR}) bags contain (?<contained>#{N_BAGS}(, #{N_BAGS})*)\.$/
    [$~[:color], $~[:contained].split(', ').map { |c| c[/^#{N_BAGS}$/, 2] or raise c }]
  else
    raise line
  end
}

expand = -> original do
  # fixed point
  new = original.deep_copy
  begin
    old, new = new.freeze, new.deep_copy
    old.each_pair { |color, contained|
      all = contained.dup
      contained.each { |c|
        all |= old.fetch(c)
      }
      new[color] = all
    }
  end until old == new
  new
end

transitive = expand.call(contain)
p transitive.each_pair.count { |color, contained| contained.include?("shiny gold") }
