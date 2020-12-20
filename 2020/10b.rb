adapters = File.readlines('10.txt').map { Integer(_1) }
adapters << 0 << adapters.max + 3

p adapters.sort.slice_when { |a, b| b - a == 3 }.map { |seq|
  dfs = -> pos {
    cur = seq[pos]
    cur == seq.last ? 1 : seq.each_with_index.sum { |e, i|
      (e - cur).between?(1, 3) ? dfs[i] : 0
    }
  }
  dfs[0]
}.reduce(:*)
