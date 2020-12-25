require 'set'

def expand(array, i = 0, val = 0, set = Set.new)
  e = array.fetch(i)
  set << val << val + e
  if i+1 < array.size
    expand(array, i+1, val, set)
    expand(array, i+1, val + e, set)
  end
  set.to_a.sort
end

mem = Hash.new(0)

File.readlines('14.txt', chomp: true).slice_before(/^mask =/).each { |program|
  mask, *operations = program
  mask = mask.split('=', 2).last.strip
  add = mask.tr('01X', '010').to_i(2)
  floating_mask = mask.tr('01X', '001').to_i(2)
  floating = expand floating_mask.digits(2).map.with_index.filter_map { |b,i| 1 << i if b == 1 }

  operations.each { |op|
    /^mem\[(\d+)\] = (\d+)$/ =~ op or raise op
    address, value = $1.to_i, $2.to_i
    address = (address | add) & ~floating_mask
    floating.each { |inc|
      mem[address + inc] = value
    }
  }
}

p mem.values.sum

