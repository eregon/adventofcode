input = File.read('2.txt')
code = input.chomp.split(',').map { |e| Integer(e) }.freeze

def interpreter(memory, input1, input2)
  memory = memory.dup
  memory[1] = input1
  memory[2] = input2

  ip = 0
  while opcode = memory[ip] and opcode != 99
    case opcode
    when 1
      a, b, out = memory[ip+1, 3]
      memory[out] = memory[a] + memory[b]
      ip += 4
    when 2
      a, b, out = memory[ip+1, 3]
      memory[out] = memory[a] * memory[b]
      ip += 4
    else
      raise "Unknown opcode: #{opcode}"
    end
  end
  
  memory[0]
end

100.times { |noun|
  100.times { |verb|
    if interpreter(code, noun, verb) == 19690720
      p 100 * noun + verb
      exit
    end
  }
}
