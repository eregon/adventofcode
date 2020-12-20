require_relative 'lib'

layout = Matrix2D.new File.readlines('11.txt', chomp: true).map { |line| line.chars.map(&:-@) }

neighbors = layout.map { |cell, pos|
  [-1i-1, -1i, -1i+1, -1, +1, 1i-1, 1i, 1i+1].filter_map { |delta|
    n = pos + delta
    n if at = layout[n] and at != '.'
  } if cell != '.'
}

after = layout.dup
begin
  before = after
  after = before.map { |cell, pos|
    if cell == 'L' and neighbors[pos].none? { |n| before[n] == '#' }
      '#'
    elsif cell == '#' and neighbors[pos].count { |n| before[n] == '#' } >= 4
      'L'
    else
      cell
    end
  }
end until before == after

puts after.count('#')
