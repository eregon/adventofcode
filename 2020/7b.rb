COLOR = /\w+ \w+/
N_BAGS = /(\d+) (#{COLOR}) bags?/

contain = File.readlines('7.txt', chomp: true).to_h { |line|
  case line
  when /^(?<color>#{COLOR}) bags contain no other bags\.$/
    [$~[:color], []]
  when /^(?<color>#{COLOR}) bags contain (?<contained>#{N_BAGS}(, #{N_BAGS})*)\.$/
    [$~[:color], $~[:contained].split(', ').to_h { |c|
      /^#{N_BAGS}$/ =~ c or raise c
      [$2, Integer($1)]
    }]
  else
    raise line
  end
}

p Hash.new { |total, color|
  total[color] = 1 + contain.fetch(color).sum { |c,q| q * total[c] }
}["shiny gold"] - 1
