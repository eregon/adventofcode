instructions = File.readlines('8.txt', chomp: true).map { |line|
  line.split.then { [_1.to_sym, Integer(_2)] }
}.freeze

def try(instructions)
  cpu = Enumerator.produce([0, 0]) { |pc, accumulator|
    case instructions.fetch(pc)
    in [:nop, _]
      [pc + 1, accumulator]
    in [:acc, n]
      [pc + 1, accumulator + n]
    in [:jmp, offset]
      [pc + offset, accumulator]
    end
  }

  visited = [false] * instructions.size
  cpu.each { |pc, acc|
    if pc == instructions.size
      return acc
    else
      if visited[pc]
        return nil
      else
        visited[pc] = true
      end
    end
  }
end

instructions.each_with_index { |instruction, i|
  case instruction
  in [:nop, arg] if arg != 0
    variant = [:jmp, arg]
  in [:jmp, offset]
    variant = [:nop, offset]
  in _
    next
  end

  try(instructions.dup.tap { |insns| insns[i] = variant })&.then { p(_1) }
}
