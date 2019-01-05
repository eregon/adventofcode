Cell = Struct.new(:pos, :neighbors) do
  def free?
    BOARD[pos.imag][pos.real].equal?(self)
  end

  def hash
    pos.hash
  end

  def eql?(cell)
    equal?(cell)
  end

  def inspect
    "#{pos}"
  end

  def to_s
    "."
  end
end

Unit = Struct.new(:type, :hp, :atk, :cell) do
  def pos
    cell.pos
  end

  def move_to(new_cell)
    leave
    self.cell = new_cell
    raise unless new_cell.free?
    BOARD[new_cell.pos.imag][new_cell.pos.real] = self
  end

  def dead?
    hp <= 0
  end

  def find_enemy(targets)
    in_range = cell.neighbors.map { |n| targets.find { |t| t.pos == n.pos } }.compact
    in_range.sort_by(&READING_ORDER).min_by(&:hp)
  end

  def attack(enemy)
    enemy.hp -= atk
    if enemy.dead?
      enemy.leave
      UNITS.delete(enemy)
    end
  end

  def leave
    BOARD[pos.imag][pos.real] = cell
  end

  def inspect
    "<#{type} #{hp} #{cell.pos}>"
  end

  def to_s
    type
  end
end

UNITS = []
CELLS = {}

ELF_ATK = Integer(ARGV[1] || 3)

BOARD = File.readlines(ARGV.first || "15.txt", chomp: true).map.with_index { |row, y|
  row.chomp.chars.map.with_index { |c, x|
    case c
    when 'G', 'E'
      cell = Cell.new(x + y.i)
      CELLS[cell.pos] = cell

      unit = Unit.new(c, 200, c == 'G' ? 3 : ELF_ATK, cell)
      UNITS << unit
      unit
    when '.'
      cell = Cell.new(x + y.i)
      CELLS[cell.pos] = cell
      cell
    when '#'
      c
    else
      raise c
    end
  }
}

WIDTH = BOARD.map(&:size).max

READING_ORDER = -> cell {
  cell.pos.imag * WIDTH + cell.pos.real
}

MOVES = [1, 1.i, -1, -1.i]

CELLS.each_value { |cell|
  cell.neighbors = MOVES.map { |move| CELLS[cell.pos + move] }.compact.sort_by(&READING_ORDER)
}

def bfs(from)
  dist = Hash.new(Float::INFINITY)
  dist[from] = 0
  q = [from]

  while cell = q.shift
    d = dist[cell]

    cell.neighbors.each { |neighbor|
      if neighbor.free?
        prev = dist[neighbor]
        if d + 1 < prev
          dist[neighbor] = d + 1
          q << neighbor
        end
      end
    }
  end

  dist
end

puts BOARD.map(&:join)
p UNITS.group_by(&:type).transform_values(&:size)

(0...Float::INFINITY).each do |round|
  UNITS.sort_by!(&READING_ORDER)
  UNITS.dup.each do |unit|
    next if unit.dead?

    targets = UNITS.select { |u| u.type != unit.type }
    if targets.empty?
      puts "#{unit.type} win"
      p round * UNITS.sum(&:hp)
      p UNITS.group_by(&:type).transform_values(&:size)
      exit
    end

    if enemy = unit.find_enemy(targets)
      unit.attack(enemy)
    else
      attack_squares = targets.flat_map { |t| t.cell.neighbors }.select(&:free?).sort_by(&READING_ORDER)

      bfs = bfs(unit.cell)
      closest = attack_squares.min_by { |as| bfs[as] }

      if closest and bfs[closest].finite?
        rbfs = bfs(closest)
        step = unit.cell.neighbors.select(&:free?).min_by { |n|
          rbfs[n]
        }
        unit.move_to(step)

        if enemy = unit.find_enemy(targets)
          unit.attack(enemy)
        end
      end
    end
  end

  puts
  p round + 1
  puts BOARD.map(&:join)
end
