p File.readlines('1.txt').sum { |line|
  mod = Integer(line)
  total = 0
  while fuel = mod / 3 - 2 and fuel > 0
    total += fuel
    mod = fuel
  end
  total
}
