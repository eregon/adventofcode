input = File.read("6.txt")
banks = input.split.map(&:to_i)

count = 0
seen = Hash.new { |h,k| h[k.dup] = count; nil }
seen[banks]

p loop {
  max_blocks = banks.max
  i_max = banks.index(max_blocks)
  banks[i_max] = 0
  max_blocks.times { |i|
    banks[(i_max + 1 + i) % banks.size] += 1
  }
  count += 1
  if v = seen[banks]
    break count - v
  end
}
p count
