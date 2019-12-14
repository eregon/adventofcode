input = File.read('13.txt')
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

require 'io/console'

TYPES = [' ', '#', '+', 'T', '*']
DIRS = %w[a s d]
tiles = Hash.new(TYPES[0])

saved_inputs = File.new('input13.txt', 'a')
saved_inputs.sync = true
inputs = File.readlines('input13.txt', chomp: true)

f = Fiber.new do
  memory = code.dup
  memory[0] = 2
  interpreter(memory, -> {
    if !inputs.empty?
      input = inputs.shift
    else
      begin
        input = STDIN.getch
        exit if input == 'q'
      end until DIRS.include?(input)
      saved_inputs.puts input
    end

    DIRS.index(input) - 1
  }, -> r { Fiber.yield(r) })
  nil
end

while x = f.resume
  y = f.resume
  id = f.resume
  if x == -1 and y == 0
    puts "Score: #{id}"
  else
    prev = tiles[x + y.i]
    if id == 0 and prev == '*'
      tiles[x + y.i] = '.'
    else
      tiles[x + y.i] = TYPES[id]
    end
  end

  puts "\n" * 50 + Range.new(*tiles.keys.map(&:imag).minmax).map { |y|
    Range.new(*tiles.keys.map(&:real).minmax).map { |x|
      tiles[x + y.i]
    }.join
  }.join("\n")
end
