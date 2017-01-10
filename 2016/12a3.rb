M = [0, 0, 0, 0]
R = /[abcd]/

def reg2idx(reg)
  reg.ord - "a".ord
end

commands = ARGF.readlines.map { |command|
  cmd, arg1, arg2 = command.split
  cmd = cmd.to_sym
  [cmd, arg1, arg2]
}
max = commands.size
pc = 0

while pc < max
  command, arg1, arg2 = commands[pc]
  opc = pc
  pc += 1
  case command
  when :cpy
    src, dst = arg1, arg2
    val = R =~ src ? M[reg2idx(src)] : src.to_i
    M[reg2idx(dst)] = val
  when :inc
    M[reg2idx(arg1)] += 1
  when :dec
    M[reg2idx(arg1)] -= 1
  when :jnz
    test, move = arg1, arg2
    val = R =~ test ? M[reg2idx(test)] : test.to_i
    unless val == 0
      pc = opc + move.to_i
    end
  else
    raise command
  end
end

p M[reg2idx("a")]
