map = {}
$<.each_with_index{ |line,y|
  line.chomp.chars.each_with_index { |c,x| map[x+y.i] = c }
}

numbers = map.each_pair.chunk { |p,c| [!!c[/\d/], p.imag] }.select { |(d,_),| d }.map(&:last)
numbers = numbers.select do |number|
  number.any? { |p,_|
    [p-1i, p-1i+1, p+1, p+1+1i, p+1i, p+1i-1, p-1, p-1-1i].any? { map[_1] =~ /[^0-9.]/ }
  }
end
p numbers.sum { _1.map(&:last).sum('').to_i }
