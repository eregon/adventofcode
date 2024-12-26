a, b, c, *program = $<.read.scan(/\d+/).map(&:to_i)

literal = :itself.to_proc

combo = -> x {
  case x
  in 0..3 then x
  in 4 then a
  in 5 then b
  in 6 then c
  end
}

ip = 0

instructions = [
  -> x { a /= (2 ** combo[x]) }, # adv
  -> x { b ^= literal[x] }, # bxl
  -> x { b = combo[x] % 8 }, # bst
  -> x { ip = literal[x] - 2 unless a == 0 }, # jnz
  -> x { b ^= c }, # bxc
  -> x { print "#{combo[x] % 8}," }, # out
  -> x { b = a / (2 ** combo[x]) }, # bdv
  -> x { c = a / (2 ** combo[x]) }, # cdv
]

while opcode = program[ip]
  instructions[opcode][program[ip + 1]]
  ip += 2
end

puts
p [a,b,c]
