data = File.read("8.txt").split.map(&:to_i)
start = sum = 0
walk = -> * {
  children, metadata = data[start...(start += 2)]
  children.times(&walk)
  metadata.times { sum += data[start] and start += 1 }
}
p walk.call && sum
