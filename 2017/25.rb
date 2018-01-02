input = File.read("25.txt")

header, *rules = input.split("\n\n")
start, steps = header.lines

start = start[/Begin in state (\w+)\./, 1]
steps = steps[/Perform a diagnostic checksum after (\d+) steps\./, 1].to_i

tape = Hash.new(0)
cursor = 0

rules = rules.map { |rule|
  lines = rule.lines
  state = lines.shift[/In state (\w+):/, 1]
  clauses = {}
  lines.each_slice(4).map { |cond|
    old_value = cond[0][/If the current value is (\d+):/, 1].to_i
    new_value = cond[1][/- Write the value (\d+)\./, 1].to_i
    move     = (cond[2][/- Move one slot to the (left|right)\./, 1].ord - ?o.ord) / 3
    new_state = cond[3][/- Continue with state (\w+)\./, 1]
    clauses[old_value] = -> {
      tape[cursor] = new_value
      cursor += move
      new_state
    }
  }
  [state, clauses]
}.to_h

state = start
steps.times do
  value = tape[cursor]
  state = rules[state][value].call
end

p tape.values.reduce(:+)
