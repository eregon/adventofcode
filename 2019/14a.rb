input = File.read('14.txt')

reactions = {}
input.each_line { |line|
  inputs, output = line.split(' => ', 2)
  n, out = output.split.then { |n,out| [Integer(n), out.to_sym] }
  raise output if reactions.key? out
  reactions[out.to_sym] = [
    Integer(n),
    inputs.split(', ').map { |input|
      q, c = input.split
      [Integer(q), c.to_sym]
    }
  ]
}

MAX_ORE = 1_000_000_000
available = { FUEL: -1, ORE: MAX_ORE }.tap { |h| h.default = 0 }

while missing = available.each_pair.find { |c,q| q < 0 }
  chemical, _needed = missing
  produced, inputs = reactions.fetch(chemical)
  inputs.each { |q,c| available[c] -= q }
  available[chemical] += produced
end

p MAX_ORE - available[:ORE]
