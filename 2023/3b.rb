map = {}
$<.each_with_index{ |line,y|
  line.chomp.chars.each_with_index { |c,x| map[x+y.i] = c }
}

gears = map.each_pair.select { _2 == '*' }.map(&:first)

p gears.sum { |g|
  adj = [g-1i, g-1i+1, g+1, g+1+1i, g+1i, g+1i-1, g-1, g-1-1i].select { map[_1] =~ /\d/ }
  adj.dup.each { |p|
    adj << p while map[p-=1] =~ /\d/
    adj << p while map[p+=1] =~ /\d/
  }
  adj = adj.uniq.sort_by { _1.rect.reverse }
  numbers = adj.slice_when { (_2 - _1) != 1 }.to_a
  numbers.size == 2 ? numbers.map { |n| n.sum('') { map[_1] }.to_i }.reduce(:*) : 0
}
