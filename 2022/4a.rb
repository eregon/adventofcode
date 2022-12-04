require_relative 'lib'

p File.readlines('4.txt', chomp: true).count { |line|
  r1, r2 = line.split(',').map { |from_to|
    from, to = from_to.split('-').map(&Int)
    (from..to)
  }
  r1.cover?(r2) || r2.cover?(r1)
}
