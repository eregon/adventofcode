data = File.readlines('3.txt', chomp: true)
gamma, epsilon = "", ""
data.first.length.times { |i|
  zeros, ones = data.map { _1[i] }.tally.values_at('0', '1')
  case zeros <=> ones
  in 1 then gamma << '0' and epsilon << '1'
  in -1 then gamma << '1' and epsilon << '0'
  end
}
p gamma.to_i(2) * epsilon.to_i(2)
