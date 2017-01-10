blacklist = ARGF.readlines.map { |line|
  line =~ /^(\d+)-(\d+)$/
  raise unless $~
  $1.to_i..$2.to_i
}

blacklist = blacklist.sort_by { |range| [range.begin, range.end] }

# p blacklist
p blacklist.take 20

distinct = [blacklist.first]
blacklist.each { |range|
  if range.begin-1 <= distinct.last.end # overlapping
    last = distinct.pop
    distinct << ([range.begin,last.begin].min..[range.end,last.end].max)
  else
    distinct << range
  end
}

blacklist = distinct
p blacklist.take 20

addr = 0
j = 0
current = blacklist[j]
while current
  if current.include? addr
    addr = current.last + 1
    current = blacklist[j += 1]
  else
    break
  end
end

p addr
