input = File.read('15.txt')
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

# north (1), south (2), west (3), and east (4)
DIRS = [nil, -1i, 1i, -1, 1]
KEYS = [nil, 'w', 's', 'a', 'd']
STATUSES = ['#', '.', 'O']

tiles = Hash.new(' ')

f = Fiber.new do
  interpreter(code, -> { Fiber.yield(:input) }, -> r { Fiber.yield(r) })
  nil
end

pos = 0 + 0i
tiles[pos] = '.'

dirs = (1..4).to_a
searching = true
steps = 0

while true
  r = f.resume
  raise r.inspect unless r == :input

  if searching
    dir = dirs.sample
  else
    begin
      input = STDIN.getch
      exit if input == 'q'
    end until KEYS.include?(input)
    dir = KEYS.index(input)
  end

  status = f.resume dir
  status = STATUSES.fetch(status)

  tiles[pos + DIRS[dir]] = status

  if status == '.'
    pos += DIRS[dir]
    steps += 1
  elsif status == 'O'
    pos += DIRS[dir]
    searching = false
    puts "Time to go back"
    steps = 0
  end

  if !searching and pos == 0 + 0.i
    break
  end

  puts "\n" * 2 + Range.new(*tiles.keys.map(&:imag).minmax).map { |y|
    Range.new(*tiles.keys.map(&:real).minmax).map { |x|
      x == 0 && y == 0 ? 'S' : x + y.i == pos ? 'D' : tiles[x + y.i]
    }.join
  }.join("\n")
  p steps unless searching
end

p steps
