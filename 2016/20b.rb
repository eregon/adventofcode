blacklist = ARGF.readlines.map { |line|
  line =~ /^(\d+)-(\d+)$/
  raise unless $~
  $1.to_i..$2.to_i
}

blacklist = blacklist.sort_by { |range| [range.begin, range.end] }

File.write 'sorted.txt', blacklist.map(&:to_s).join("\n")

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
p blacklist.take 40
p blacklist.last
# puts blacklist


n = blacklist.first.begin
blacklist.each_cons(2) { |a,b|
  d = (b.begin-a.last-1)
  raise unless d > 0
  n += d
}
max = 2**32 - 1 # 9
n += (max - blacklist.last.end)
p n
