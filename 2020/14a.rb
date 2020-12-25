mem = Hash.new(0)

File.readlines('14.txt', chomp: true).slice_before(/^mask =/).each { |program|
  mask, *operations = program
  mask = mask.split('=', 2).last.strip
  remove = mask.tr('01X', '100').to_i(2)
  add = mask.tr('01X', '010').to_i(2)

  operations.each { |op|
    /^mem\[(\d+)\] = (\d+)$/ =~ op or raise op
    address, value = $1.to_i, $2.to_i
    mem[address] = (value & ~remove) | add
  }
}

p mem.values.sum

