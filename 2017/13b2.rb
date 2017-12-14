input = File.read("13.txt")

# .cycle is too slow
class CycleEnumerator
  def initialize(array)
    @array = array
    @pos = 0
  end

  def next
    pos = @pos
    @pos = (pos+1) % @array.size
    @array[pos]
  end
end

Scanner = Struct.new(:depth, :range, :cycle, :pos) do
  def initialize_copy(other)
    super
    self.cycle = other.cycle.dup
  end

  def advance
    self.pos = cycle.next
  end
end

scanners = input.strip.lines.map { |line|
  depth, range = line.split(': ').map(&:to_i)
  cycle = CycleEnumerator.new [*(0...range), *(range-2).downto(1)]
  Scanner.new(depth, range, cycle, cycle.next)
}

def copy(scanners)
  scanners.map(&:dup)
end

last = scanners

p (1...Float::INFINITY).find { |delay|
  p delay if delay % 100_000 == 0

  scanners = last
  scanners.each(&:advance)
  last = copy(scanners)

  by_depth = []
  scanners.each { |s| by_depth[s.depth] = s }

  by_depth.each_with_index.none? { |scanner, depth|
    scanner&.pos&.zero?.tap {
      scanners.each(&:advance)
    }
  }
}
