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

regs = /\[(\d+), (\d+), (\d+), (\d+)\]/
numbers = /(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/
regexp = /^Before:\s*#{regs}\n#{numbers}\nAfter:\s*#{regs}/
samples = File.read("16.txt").scan(regexp).map { |matches| matches.map(&:to_i) }

mapping = instructions.size.times.map { instructions.keys }

samples.each { |data|
  before, opcode, inputs, after = data[0...4], data[4], data[5...8], data[8...12]
  before.freeze

  mapping[opcode] &= instructions.each_pair.select { |instr, action|
    regs = before.dup
    action[regs, *inputs]
    regs == after
  }.map(&:first)
}

while mapping.any? { |instrs| instrs.size > 1 }
  mapping.each_with_index { |instrs, i|
    if instrs.size == 1
      mapping.each_index { |j|
        mapping[j] -= instrs if i != j
      }
    end
  }
end

mapping.map!(&:first)

program = File.read("16.txt")[/\n{4}(\d.+)\z/m, 1].lines.map { |line| line.split.map(&:to_i) }
regs = [0] * 4
program.each { |opcode, a, b, c|
  instructions[mapping[opcode]][regs, a, b, c]
}
p regs
