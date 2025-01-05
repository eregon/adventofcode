code = $<.read.split(',').map(&:to_i).freeze

def run(code)
  memory = code.dup
  opcode = 0
  ip = 0

  get_mode = -> nth {
    opcode / (10 ** (nth + 1)) % 10
  }

  write = -> nth, value {
    address = memory[ip + nth]
    case get_mode[nth]
    in 0
      memory[address] = value
    end
  }

  read = -> nth {
    v = memory[ip + nth]
    case get_mode[nth]
    in 0
      memory[v]
    in 1
      v
    end
  }

  loop do
    opcode = memory[ip]
    instruction = opcode % 100
    case instruction
    in 1 # add
      a = read[1]
      b = read[2]
      write[3, a + b]
      ip += 4
    in 2 # multiply
      a = read[1]
      b = read[2]
      write[3, a * b]
      ip += 4
    in 3 # input
      input_value = 1
      write[1, input_value]
      ip += 2
    in 4 # output
      p read[1]
      ip += 2
    in 99
      break
    end
  end

  memory
end

run(code)
