instructions = {}
addressing = -> mode, arg { mode == :r ? "regs[#{arg}]" : arg }
def_instr = -> name, mode_a, mode_b, &block do
  instructions[name] = "-> regs, a, b, c {
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
program = program.map.with_index { |line, i|
  instr, *args = line.split
  action = instructions[instr.to_sym]
  a, b, c = args
  print ("# %02d)  " % i)
  puts action.lines[1].strip
    .sub(/\ba\b/, a).sub(/\bb\b/, b).sub(/\bc\b/, c)
    .gsub(/(=.+)regs\[#{ip}\]/, "\\1#{i}")
    .gsub(/regs\[(\d+)\]/,
      "regs[0]" => "a", "regs[1]" => "b", "regs[2]" => "c",
      "regs[3]" => "pc", "regs[4]" => "d", "regs[5]" => "e")
    .sub(/^(\w+) = \1 ([*+]) (\w+)$/, '\1 \2= \3')
    .sub(/^(\w+) = (\w+) ([*+]) \1$/, '\1 \3= \2')
    .sub(/\b(\d+) ([*+]) (\d+)\b/) { $1.to_i.send($2, $3.to_i) }
}
