require 'matrix'

input = File.read("21.txt")

class Matrix
  def self.from(str)
    Matrix[*str.split('/').map { |row| row.chars.map { |c| c == '#' } }]
  end

  def to_s
    "\n" + to_a.map { |row| row.map { |c| c ? '#' : '.' }.join }.join("\n")
  end
end

board = Matrix.from(".#./..#/###")

rules = {}
input.lines.each { |line|
  line =~ /^([.#\/]+) => ([.#\/]+)$/
  pattern, replacement = [$1, $2].map(&Matrix.method(:from))
  [pattern, pattern.transpose].each { |m|
    m = m.to_a
    [
      Matrix[*m],
      Matrix[*m.reverse],
      Matrix[*m.map(&:reverse)],
      Matrix[*m.map(&:reverse).reverse]
    ].each { |pattern|
      rules[pattern] = Matrix[*replacement]
    }
  }
}

(1..18).each do |i|
  size = board.row_count
  n = size.even? ? 2 : 3
  raise unless size % n == 0
  board = Matrix.vstack *size.times.each_slice(n).map { |i,|
    Matrix.hstack *size.times.each_slice(n).map { |j,|
      rules.fetch board.minor(i, n, j, n)
    }
  }
  # p i
  # puts board

  if i == 5 or i == 18
    p board.to_a.flat_map(&:itself).count(&:itself)
  end
end
