instructions = File.readlines('8.txt', chomp: true).map { |line|
  line.split.then { [_1.to_sym, Integer(_2)] }
}

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
p cpu.find { |pc, acc| visited[pc] or (visited[pc] = true and next) }.last
