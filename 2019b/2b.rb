code = $<.read.split(',').map(&:to_i).freeze

def run(code, noun, verb)
  memory = code.dup
  memory[1] = noun
  memory[2] = verb

  memory.each_slice(4) { |opcode, a, b, r|
    case opcode
    in 1
      memory[r] = memory[a] + memory[b]
    in 2
      memory[r] = memory[a] * memory[b]
    in 99
      break
    end
  }

  memory[0]
end

100.times { |noun|
  100.times { |verb|
    if run(code, noun, verb) == 19690720
      p 100 * noun + verb
      exit
    end
  }
}
