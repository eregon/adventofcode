n = 36000000

max = 10

loop {
  gifts = Array.new(max+1, 0)
  gifts[0] = -1

  (1..max).each { |elf|
    h = elf
    begin
      gifts[h] += 10 * elf
      h += elf
    end while h < max
  }

  if i = gifts.find_index { |g| g >= n }
    p i
    #p gifts
    exit
  end

  max *= 10
  p max
}
