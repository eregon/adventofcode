input = File.read("13.txt")

Scanner = Struct.new(:depth, :range, :cycle, :pos) do
  def advance
    self.pos = cycle.next
  end
end

by_depth = {}
scanners = input.strip.lines.map { |line|
  depth, range = line.split(': ').map(&:to_i)
  cycle = [*(0...range), *(range-2).downto(1)].cycle
  by_depth[depth] = Scanner.new(depth, range, cycle, cycle.next)
}

p (0..scanners.map(&:depth).max).sum { |depth|
  if scanner = by_depth[depth] and scanner.pos == 0
    scanner.depth * scanner.range
  else
    0
  end.tap {
    scanners.each(&:advance)
  }
}
