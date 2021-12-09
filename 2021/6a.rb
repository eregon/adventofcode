require_relative 'lib'

lanternfish = File.read('6.txt').chomp.split(',').map(&Integer)

80.times { |day|
  n = lanternfish.size
  n.times { |i|
    age = lanternfish[i]
    lanternfish[i] = if age > 0
      age - 1
    else
      lanternfish << 8
      6
    end
  }
}
p lanternfish.size
