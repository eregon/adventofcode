M = [0, 0, 0, 0]
# M[2] = 1

R = /[abcd]/

def reg2idx(reg)
  reg.ord - "a".ord
end

def val(expr)
  if R =~ expr
    i = reg2idx(expr)
    -> { M[i] }
  else
    v = Integer(expr)
    -> { v }
  end
end

program = ARGF.readlines.map(&:chomp).map { |command|
  case command
  when /^cpy (\d+|#{R}) (#{R})$/
    src, dst = $1, reg2idx($2)
    val = val(src)
    -> pc { M[dst] = val.(); pc+1 }
  when /^inc (#{R})$/
    r = reg2idx($1)
    -> pc { M[r] += 1; pc+1 }
  when /^dec (#{R})$/
    r = reg2idx($1)
    -> pc { M[r] -= 1; pc+1 }
  when /^jnz (\d+|#{R}) (-?\d+)$/
    test = val($1)
    move = val($2).()
    -> pc { test.() == 0 ? pc+1 : pc+move }
  else
    raise command
  end
}

max = program.size
pc = 0
while pc < max
  pc = program[pc][pc]
end
p M[reg2idx("a")]
