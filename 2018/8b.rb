data = File.read("8.txt").chomp.split.map { |e| Integer(e) }
walk = -> start do
  children, metadata = data[start...(start += 2)]
  children_values = children.times.map {
    (start, _ = walk.call(start))[1]
  }
  value = metadata.times.sum {
    v = data[start]
    start += 1

    if children > 0
      if (1..children).include?(v)
        children_values[v-1]
      else
        0
      end
    else
      v
    end
  }
  [start, value]
end

p walk.call(0)[1]
