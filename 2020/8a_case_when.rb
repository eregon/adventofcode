instructions = File.readlines('8.txt', chomp: true).map { |line|
  line.split.then { [_1.to_sym, Integer(_2)] }
}

cpu = Enumerator.produce([0, 0]) { |pc, accumulator|
  operation, argument = instructions.fetch(pc)
  case operation
  when :nop
    [pc + 1, accumulator]
  when :acc
    [pc + 1, accumulator + argument]
  when :jmp
    [pc + argument, accumulator]
  else
    raise operation
  end
}

visited = [false] * instructions.size
p cpu.find { |pc, acc| visited[pc] or (visited[pc] = true and next) }.last
