input = File.read("10.txt").strip

list = 256.times.to_a
lenghts = input.bytes + [17, 31, 73, 47, 23]
pos = 0
skip = 0

64.times do
  lenghts.each { |length|
    list = list.rotate(pos).yield_self { |rotated|
      rotated[0...length].reverse + rotated[length..-1]
    }.rotate(-pos)
    pos += length + skip
    skip += 1
  }
end

p list.each_slice(16).map { |bytes| "%02x" % bytes.reduce(:^) }.join
