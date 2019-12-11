input = File.read('11.txt')
code = input.chomp.split(',').map { |e| Integer(e) }.freeze

def interpreter(memory, input, output)
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
      write[1, input.call]
      ip += 2
    when 4 # output
      output.call(read[1])
      ip += 2
    when 5 # jump-if-true
      ip = read[1] != 0 ? read[2] : ip + 3
    when 6 # jump-if-false
      ip = read[1] == 0 ? read[2] : ip + 3
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
end

BLACK = 0
WHITE = 1
DIRS = [-1i, 1, 1i, -1]

pos = 0 + 0i
dir = DIRS[0]
panels = Hash.new(BLACK)

f = Fiber.new do
  interpreter(code, -> { panels[pos] }, -> r { Fiber.yield(r) })
  nil
end

while color = f.resume
  panels[pos] = color

  direction = f.resume
  case direction
  when 0 # left
    dir = DIRS[(DIRS.index(dir) - 1) % DIRS.size]
  when 1 # right
    dir = DIRS[(DIRS.index(dir) + 1) % DIRS.size]
  else
    raise direction
  end
  pos += dir
end

p panels.size
