require_relative 'lib'

def negate(n) = n > 0 ? -n : (n == 0 ? -Float::INFINITY : raise)

numbers, _, *boards = File.readlines('4.txt', chomp: true)
numbers = numbers.split(',').map(&Integer)

boards = boards.join("\n").split("\n\n").map { |board|
  board.lines.map { _1.split.map(&Integer) }
}

numbers.each { |n|
  boards.each { |board|
    board.each { |row|
      if i = row.index(n)
        row[i] = negate(n)
        if row.all?(&:negative?) or
            board.map { _1[i] }.all?(&:negative?)
          p board.flatten.reject(&:negative?).sum * n
          exit
        end
      end
    }
  }
}
