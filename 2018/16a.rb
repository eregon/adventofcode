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

p samples.count { |data|
  before, inputs, after = data[0...4], data[5...8], data[8...12]
  before.freeze
  instructions.each_pair.count { |instr, action|
    regs = before.dup
    action[regs, *inputs]
    regs == after
  } >= 3
}
