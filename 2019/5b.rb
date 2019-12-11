input = File.read('5.txt')
code = input.chomp.split(',').map { |e| Integer(e) }.freeze

def interpreter(memory, inputs)
  memory = memory.dup
  ip = 0
  mode = 0

  get_mode = -> i {
    # mode.digits[i-1] || 0
    mode / (10 ** (i-1)) % 10
  }

  read = -> i {
    v = memory[ip + i]
    case m = get_mode[i]
    when 0
      memory[v]
    when 1
      v
    else
      raise "Unknown read mode #{m} (#{mode} #{i})"
    end
  }
  
  write = -> i, result {
    v = memory[ip + i]
    case m = get_mode[i]
    when 0
      memory[v] = result
    else
      raise "Unknown write mode #{m} (#{mode} #{i})"
    end
  }

  while true
    instruction = memory[ip]
    mode, opcode = instruction.divmod(100)
    case opcode
    when 1 # add
      write[3, read[1] + read[2]]
      ip += 4
    when 2 # multiply
      write[3, read[1] * read[2]]
      ip += 4
    when 3 # input
      write[1, inputs.shift || raise]
      ip += 2
    when 4 # output
      p read[1]
      ip += 2
    when 5 # jump-if-true
      if read[1] != 0
        ip = read[2]
      else
        ip += 3
      end
    when 6 # jump-if-false
      if read[1] == 0
        ip = read[2]
      else
        ip += 3
      end
    when 7 # less than
      write[3, read[1] < read[2] ? 1 : 0]
      ip += 4
    when 8 # equals
      write[3, read[1] == read[2] ? 1 : 0]
      ip += 4
    when 99
      break
    else
      raise "Unknown opcode: #{opcode} at #{ip} (#{instruction})"
    end
  end
end

interpreter(code, [5])
