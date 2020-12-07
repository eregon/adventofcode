require 'set'

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

expand = Hash.new { |expanded, color|
  expanded[color] = contain[color].inject(contain[color].to_set) { |all, c|
    all.merge(expand[c])
  }
}

p contain.keys.count { |color| expand[color].include?("shiny gold") }
