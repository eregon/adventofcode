input = ARGF.readlines

REGS = regs = {a: 0, b: 0, c: 0, d: 0}

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

0.step do |n|
  regs.replace({a: n, b: 0, c: 0, d: 0})
  stats = instrs.map { 0 }
  p n
  begin
    pc = 0
    out_i = 0
    out = []
    twenty27 = 0
    while pc < instrs.size
      cmd, arg1, arg2 = instrs[pc]
      case cmd
      when :add
        regs[arg1] += regs[arg2]
        regs[arg2] = 0
        pc += 3
        next
      when :mul
        regs[:a] = regs[arg1] * regs[arg2]
        regs[:c] = 0
        regs[:d] = 0
        pc += 6
        next
      when :inc
        regs[arg1] += 1
      when :dec
        regs[arg1] -= 1
      when :cpy
        regs[arg2] = val(arg1)
      when :jnz
        if val(arg1) != 0
          pc += val(arg2)
          next
        end
      when :out
        v = regs[arg1]
        out << v
        break unless v == out_i % 2
        out_i += 1
        break if out_i > 30
      else
        raise cmd.to_s
      end
      pc += 1
    end
  ensure
    if out.size >= 30
      p regs
      p out
      puts
    end
  end
end
