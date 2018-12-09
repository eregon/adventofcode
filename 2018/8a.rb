data = File.read("8.txt").chomp.split.map { |e| Integer(e) }
sum = 0
walk = -> start do
  children, metadata = data[start...(start += 2)]
  children.times {
    start = walk.call(start)
  }
  metadata.times {
    sum += data[start]
    start += 1
  }
  start
end

walk.call(0)
p sum
