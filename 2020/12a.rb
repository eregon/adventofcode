require_relative 'lib'

steps = File.readlines('12.txt', chomp: true).map { |line| line[/^(\w)(\d+)$/] and [$1.to_sym, $2.to_i] }
MOVES = { N: 1i, E: 0i+1, S: -1i, W: 0i-1 }
DIRS = RepeatingArray.new MOVES.values

pos = 0 + 0i
dir = MOVES[:E]

steps.each { |instr, n|
  if MOVES.key?(instr)
    pos += MOVES[instr] * n
  else
    case instr
    in :F
      pos += dir * n
    in :L
      dir = DIRS[DIRS.index(dir) - n/90]
    in :R
      dir = DIRS[DIRS.index(dir) + n/90]
    end
  end
}

p pos.rect.sum(&:abs)
