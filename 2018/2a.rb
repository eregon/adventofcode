counts = { 2=> 0, 3 => 0 }
File.foreach("2.txt", chomp: true) { |line|
  twice = thrice = false
  line.chars.uniq.each { |c|
    twice ||= line.count(c) == 2
    thrice ||= line.count(c) == 3
  }
  counts[2] += 1 if twice
  counts[3] += 1 if thrice
}

p counts[2] * counts[3]
