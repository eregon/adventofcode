instructions = File.readlines('8.txt', chomp: true).map { |line|
  line.split.then { [_1.to_sym, Integer(_2)] }
}

visited = [false] * instructions.size
pc, accumulator = 0, 0

until visited[pc]
  visited[pc] = true
  operation, argument = instructions.fetch(pc)
  case operation
  when :nop
  when :acc
    accumulator += argument
  when :jmp
    next pc += argument
  else
    raise operation
  end
  pc += 1
end

p accumulator
