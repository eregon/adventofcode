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

needed_ore = 0
available = { FUEL: -1 }.tap { |h| h.default = 0 }

while missing = available.each_pair.find { |c,q| q < 0 }
  chemical, needed = missing
  if chemical == :ORE
    needed_ore += needed.abs
    available[:ORE] = 0
  else
    produced, inputs = reactions.fetch(chemical)
    inputs.each { |q,c| available[c] -= q }
    available[chemical] += produced
  end
end

p needed_ore
