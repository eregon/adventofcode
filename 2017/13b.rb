input = File.read("13.txt")

scanners = input.strip.lines.map { |line|
  depth, range = line.split(': ').map(&:to_i)
  cycle = [*(0...range), *(range-2).downto(1)]
  [depth, range, cycle]
}

p (0...Float::INFINITY).find { |delay|
  scanners.none? { |depth, range, cycle|
    cycle[(delay + depth) % cycle.size] == 0
  }
}
