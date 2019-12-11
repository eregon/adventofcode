input = File.read('2.txt')
code = input.chomp.split(',').map { |e| Integer(e) }

code[1] = 12
code[2] = 02

pc = 0
while opcode = code[pc] and opcode != 99
  case opcode
  when 1
    a, b, out = code[pc+1, 3]
    code[out] = code[a] + code[b]
    pc += 4
  when 2
    a, b, out = code[pc+1, 3]
    code[out] = code[a] * code[b]
    pc += 4
  else
    raise "Unknown opcode: #{opcode}"
  end
end

p code[0]
