M = [0, 0]
M[0] = 1

R = /[ab]/

def reg2idx(reg)
  reg.ord - "a".ord
end

program = ARGF.readlines.map(&:chomp).map { |command|
  case command
  when /^hlf (#{R})$/
    r = reg2idx($1)
    -> pc { M[r] /= 2; pc+1 }
  when /^tpl (#{R})$/
    r = reg2idx($1)
    -> pc { M[r] *= 3; pc+1 }
  when /^inc (#{R})$/
    r = reg2idx($1)
    -> pc { M[r] += 1; pc+1 }
  when /^jmp ([+-]\d+)$/
    offset = Integer($1)
    -> pc { pc+offset }
  when /^jie (#{R}), ([+-]\d+)$/
    r = reg2idx($1)
    offset = Integer($2)
    -> pc { M[r].even? ? pc+offset : pc+1 }
  when /^jio (#{R}), ([+-]\d+)$/
    r = reg2idx($1)
    offset = Integer($2)
    -> pc { M[r] == 1 ? pc+offset : pc+1 }
  else
    raise command
  end
}

max = program.size
pc = 0
while pc < max
  pc = program[pc][pc]
end
p M
