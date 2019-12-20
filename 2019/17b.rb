input = File.read('17.txt')
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

f = Fiber.new do
  memory = code.dup
  # memory[0] = 2
  interpreter(code, -> { Fiber.yield(:input) }, -> r { Fiber.yield(r) })
  nil
end

DIRS = [-1i, 1i, -1, 1]
tiles = Hash.new('.')
pos = 0 + 0i
initial_pos = nil
current_dir = nil

while c = f.resume
  c = c.chr
  if i = %w[^ v < >].index(c)
    c = '#'
    initial_pos = pos
    current_dir = DIRS[i]
  end

  if c == "\n"
    pos = 0 + (pos.imag + 1).i
  else
    tiles[pos] = c
    pos += 1
  end
end

intersections = tiles.keys.select { |pos|
  tiles[pos] == '#' and DIRS.all? { |dir| tiles[pos + dir] == '#' }
}

tiles = tiles.select { |pos,c| c == '#' }.to_h

puts Range.new(*tiles.keys.map(&:imag).minmax).map { |y|
  Range.new(*tiles.keys.map(&:real).minmax).map { |x|
    pos = x + y.i
    pos == initial_pos ? 'V' : tiles[pos] || ' '
  }.join
}.join("\n")

p current_dir

pos = initial_pos
visited = [initial_pos]
until visited.size == tiles.size
  dirs = DIRS.map { |dir| pos + dir }.select { |at|
    tiles[at] and !visited.include?(at)
  }
  if dirs.size > 1
    raise unless dirs.include?
  end
end
