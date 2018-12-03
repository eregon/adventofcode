boxes = File.readlines("2.txt", chomp: true)

puts boxes.product(boxes).each { |box1, box2|
  if box1.chars.zip(box2.chars).count { |c1,c2| c1 != c2 } == 1
    break box1.chars.zip(box2.chars).select { |c1,c2| c1 == c2 }.map(&:first).join
  end
}
