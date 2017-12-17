steps = 314
buffer = [0]
pos = 0

2017.times do |i|
  pos = (pos + steps) % buffer.size
  buffer.insert pos+1, i+1
  pos += 1
end

p buffer[buffer.index(2017)+1]
