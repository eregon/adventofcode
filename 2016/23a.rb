input = <<EOS.lines
cpy 2 a
tgl a
tgl a
tgl a
cpy 1 a
dec a
dec a
EOS

input = ARGF.readlines

REGS = regs = {a: 0, b: 0, c: 0, d: 0}
# regs[:a] = 7
regs[:a] = 12


def val(expr)
  if Symbol === expr
    REGS[expr]
  else
    expr
  end
end

def operand(op)
  if ('a'..'d').include?(op)
    op.to_sym
  else
    Integer(op)
  end
end


instrs = input.map { |instr|
  cmd, arg1, arg2 = instr.chomp.split
  arg1 = operand(arg1) if arg1
  arg2 = operand(arg2) if arg2
  [cmd.to_sym, arg1, *arg2]
}

stats = instrs.map { 0 }

begin
  pc = 0
  while pc < instrs.size
    stats[pc] += 1
    cmd, arg1, arg2 = instrs[pc]
    case cmd
    when :add
      regs[arg1] += regs[arg2]
      regs[arg2] = 0
      pc += 3
    when :mul
      regs[:a] = regs[arg1] * regs[arg2]
      regs[:c] = 0
      regs[:d] = 0
      pc += 6
    when :inc
      regs[arg1] += 1
      pc += 1
    when :dec
      regs[arg1] -= 1
      pc += 1
    when :cpy
      regs[arg2] = val(arg1)
      pc += 1
    when :jnz
      if val(arg1) != 0
        pc += val(arg2)
      else
        pc += 1
      end
    when :tgl
      i = pc + regs[arg1]
      p [:tgl, i, instrs[i]]
      if instr = instrs[i]
        instrs[i] = if instr.size == 2
          cmd, arg1 = instr
          case cmd
          when :inc
            [:dec, arg1]
          else
            [:inc, arg1]
          end
        elsif instr.size == 3
          cmd, arg1, arg2 = instr
          case cmd
          when :add, :mul
            raise instr.to_s
          when :jnz
            [:cpy, arg1, arg2]
          else
            [:jnz, arg1, arg2]
          end
        else
          raise instr.to_s
        end
      end
      pc += 1
    else
      raise cmd.to_s
    end
  end
ensure
  p stats
  p regs
end

