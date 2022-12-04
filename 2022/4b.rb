require_relative 'lib'

class Range
  def overlap?(range)
    self.include?(range.begin) or self.include?(range.end) or
    range.include?(self.begin) or range.include?(self.end)
  end
end

p File.readlines('4.txt', chomp: true).count { |line|
  r1, r2 = line.split(',').map { |from_to|
    from, to = from_to.split('-').map(&Int)
    (from..to)
  }
  r1.overlap?(r2)
}
