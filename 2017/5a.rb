input = File.read("5.txt")
code = input.strip.lines.map(&:to_i)

pc = 0
steps = 0
while pc.between?(0, code.size-1)
  jump = code[pc]
  code[pc] += 1
  pc += jump
  steps += 1
end
p steps
