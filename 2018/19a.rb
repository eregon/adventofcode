instructions = {}
addressing = -> mode, arg { mode == :r ? "regs[#{arg}]" : arg }
def_instr = -> name, mode_a, mode_b, &block do
  instructions[name] = eval "-> regs, a, b, c {
    #{block.(addressing[mode_a, "a"], addressing[mode_b, "b"], addressing[:r, "c"])}
  }"
end

[:r, :i].each do |mode|
  { add: :+, mul: :*, ban: :&, bor: :| }.each_pair { |name, op|
    def_instr.(:"#{name}#{mode}", :r, mode) { |a, b, c|
      "#{c} = #{a} #{op} #{b}"
    }
  }

  def_instr.(:"set#{mode}", mode, :i) { |a, b, c|
    "#{c} = #{a}"
  }
end

[ [:i, :r], [:r, :i], [:r, :r] ].each do |mode_a, mode_b|
  { gt: :>, eq: :== }.each_pair { |name, cmp|
    def_instr.(:"#{name}#{mode_a}#{mode_b}", mode_a, mode_b) { |a, b, c|
      "#{c} = #{a} #{cmp} #{b} ? 1 : 0"
    }
  }
end

ip, *program = File.readlines("19.txt", chomp: true)
ip = ip[/#ip (\d+)/, 1].to_i
program = program.map { |line|
  instr, *args = line.split
  action = instructions[instr.to_sym]
  a, b, c = args.map(&:to_i)
  -> regs { action.(regs, a, b, c) }
}

regs = [0] * 6
while regs[ip].between?(0, program.size-1)
  program[regs[ip]].call(regs)
  regs[ip] += 1
end
p regs
