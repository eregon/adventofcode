input = File.read("10.txt").strip.split(',').map(&:to_i)

list = 256.times.to_a
lenghts = input
pos = 0
skip = 0

lenghts.each { |length|
  list = list.rotate(pos).yield_self { |rotated|
    rotated[0...length].reverse + rotated[length..-1]
  }.rotate(-pos)
  pos += length + skip
  skip += 1
}

p list[0, 2].reduce(:*)
