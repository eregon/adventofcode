input = File.read("23.txt")

REGISTERS = registers = Hash.new(0)

REG = /[a-z]/
OP = /(?:#{REG}|-?\d+)/

def val(str)
  if REG =~ str
    r = str
    -> { REGISTERS[r] }
  else
    v = Integer(str)
    -> { v }
  end
end

muls = 0
code = input.strip.lines.map { |line|
  case line
  when /^set (#{REG}) (#{OP})$/
    r, v = $1, val($2)
    -> { registers[r] = v.call }
  when /^sub (#{REG}) (#{OP})$/
    r, v = $1, val($2)
    -> { registers[r] -= v.call }
  when /^mul (#{REG}) (#{OP})$/
    r, v = $1, val($2)
    -> { registers[r] *= v.call; muls += 1 }
  when /^jnz (#{OP}) (#{OP})$/
    v, off = val($1), val($2)
    -> pc { pc + (v.call != 0 ? off.call : 1) }
  else
    raise line
  end
}

pc = 0
while instr = code[pc]
  if instr.arity == 0
    instr.call
    pc += 1
  else
    pc = instr.call(pc)
  end
end
p muls
