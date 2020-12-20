require_relative 'lib'
using Refinements

steps = File.readlines('12.txt', chomp: true).map { |line| line[/^(\w)(\d+)$/] and [$1.to_sym, $2.to_i] }
MOVES = { N: 1i, E: 0i+1, S: -1i, W: 0i-1 }

pos = 0 + 0i
waypoint = 10 + 1i

steps.each { |instr, n|
  if MOVES.key?(instr)
    waypoint += MOVES[instr] * n
  else
    case instr
    in :F
      pos += waypoint * n
    in :L | :R
      n = -n if instr == :R
      waypoint = Complex.polar(waypoint.abs, waypoint.angle + n/180.0*Math::PI).round
    end
  end
}

p pos.rect.sum(&:abs)
