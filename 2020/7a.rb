require 'set'

COLOR = /\w+ \w+/
N_BAGS = /(\d+) (#{COLOR}) bags?/

contain = File.readlines('7.txt', chomp: true).to_h { |line|
  case line
  when /^(?<color>#{COLOR}) bags contain no other bags\.$/
    [$~[:color], []]
  when /^(?<color>#{COLOR}) bags contain (?<contained>#{N_BAGS}(, #{N_BAGS})*)\.$/
    [$~[:color], $~[:contained].split(', ').map { |c| c[/^#{N_BAGS}$/, 2] or raise c }.to_set]
  else
    raise line
  end
}

expand = -> original do
  # fixed point
  expanded = original.dup.transform_values(&:dup)
  begin
    changed = false
    expanded.each_pair { |color, contained|
      contained.to_a.each { |c|
        expanded[c].each { |cc|
          changed = true if contained.add?(cc)
        }
      }
    }
  end while changed
  expanded
end

transitive = expand.call(contain)
p transitive.each_pair.count { |color, contained| contained.include?("shiny gold") }
