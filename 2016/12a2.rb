M = [0, 0, 0, 0]
R = /[abcd]/

def reg2idx(reg)
  reg.ord - "a".ord
end

commands = ARGF.readlines.map(&:chomp)
max = commands.size
pc = 0

while pc < max
  command = commands[pc]
  opc = pc
  pc += 1
  case command
  when /^cpy (\d+|#{R}) (#{R})$/
    src, dst = $1, $2
    val = R =~ src ? M[reg2idx(src)] : src.to_i
    M[reg2idx(dst)] = val
  when /^inc (#{R})$/
    M[reg2idx($1)] += 1
  when /^dec (#{R})$/
    M[reg2idx($1)] -= 1
  when /^jnz (\d+|#{R}) (-?\d+)$/
    test, move = $1, $2
    val = R =~ test ? M[reg2idx(test)] : test.to_i
    unless val == 0
      pc = opc + move.to_i
    end
  else
    raise command
  end
end

p M[reg2idx("a")]
