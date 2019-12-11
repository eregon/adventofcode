input = File.read('7.txt')
code = input.chomp.split(',').map { |e| Integer(e) }.freeze

def interpreter(memory, inputs, output)
  memory = memory.dup
  ip = 0
  mode = 0

  get_mode = -> i {
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
      input = inputs.shift or raise
      write[1, input]
      ip += 2
    when 4 # output
      result = read[1]
      inputs << output.transfer(result) if output.alive?
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

  result # returns to root fiber
end

n = 5
best = 0
best_phases = nil
require 'fiber'

(5..9).to_a.permutation(n) { |phases|
  amplifiers = n.times.map { |i|
    phase = phases[i]
    Fiber.new { |signal|
      interpreter(code, [phase, signal], amplifiers[(i + 1) % n])
    }
  }

  signal = 0
  amplifiers.each { |amplifier|
    signal = amplifier.transfer(signal)
  }

  if signal > best
    best = signal
    best_phases = phases.dup
  end
}

p best
p best_phases
