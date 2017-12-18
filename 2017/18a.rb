input = File.read("18.txt")

REGISTERS = registers = Hash.new(0)
last_sound = nil

REG = /[a-z]/
OP = /(?:#{REG}|-?\d+)/

# Needs to be a method, otherwise $~ is shared with below
def val(str)
  if REG =~ str
    r = str
    -> { REGISTERS[r] }
  else
    v = Integer(str)
    -> { v }
  end
end

code = input.strip.lines.map { |line|
  case line
  when /^set (#{REG}) (#{OP})$/
    r, v = $1, val($2)
    -> { registers[r] = v.call }
  when /^add (#{REG}) (#{OP})$/
    r, v = $1, val($2)
    -> { registers[r] += v.call }
  when /^mul (#{REG}) (#{OP})$/
    r, v = $1, val($2)
    -> { registers[r] *= v.call }
  when /^mod (#{REG}) (#{OP})$/
    r, v = $1, val($2)
    -> { registers[r] %= v.call }
  when /^snd (#{OP})$/
    v = val($1)
    -> { last_sound = v.call }
  when /^rcv (#{OP})$/
    v = val($1)
    -> {
      if v.call != 0
        p last_sound
        exit
      end
    }
  when /^jgz (#{OP}) (#{OP})$/
    v, off = val($1), val($2)
    -> pc { pc + (v.call > 0 ? off.call : 1) }
  else
    raise line
  end
}

loop {
  pc = 0
  while instr = code[pc]
    if instr.arity == 0
      instr.call
      pc += 1
    else
      pc = instr.call(pc)
    end
  end
}
