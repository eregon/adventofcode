input = File.read('9.txt')
code = input.chomp.split(',').map { |e| Integer(e) }.freeze

def interpreter(memory, inputs)
  memory = memory.dup
  def memory.[](i)
    raise if i < 0
    super(i) || 0
  end
  ip = 0
  mode = 0
  relative_base = 0

  get_mode = -> i {
    mode / (10 ** (i-1)) % 10
  }

  read = -> i {
    v = memory[ip + i]
    case m = get_mode[i]
    when 0 # position
      memory[v]
    when 1 # immediate
      v
    when 2 # relative
      memory[relative_base + v]
    else
      raise "Unknown read mode #{m} (#{mode} #{i})"
    end
  }
  
  write = -> i, result {
    v = memory[ip + i]
    case m = get_mode[i]
    when 0 # position
      memory[v] = result
    when 2 # relative
      memory[relative_base + v] = result
    else
      raise "Unknown write mode #{m} (#{mode} #{i})"
    end
  }

  result = nil
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
      input = inputs.shift || raise
      write[1, input]
      ip += 2
    when 4 # output
      result = read[1]
      puts "Output: #{result}"
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
    when 9 # relative base offset
      relative_base += read[1]
      ip += 2
    when 99
      break
    else
      raise "Unknown opcode: #{opcode} at #{ip} (#{instruction})"
    end
  end
  result
end

p interpreter(code, [1])
