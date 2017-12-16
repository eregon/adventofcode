key = "xlqgujun"

def knot_hash(str)
  list = 256.times.to_a
  lenghts = str.bytes + [17, 31, 73, 47, 23]
  pos, skip = 0, 0
  64.times do
    lenghts.each { |length|
      list = list.rotate(pos).yield_self { |rotated|
        rotated[0...length].reverse + rotated[length..-1]
      }.rotate(-pos)
      pos += length + skip
      skip += 1
    }
  end
  list
end

rows = 128.times.map { |i| "#{key}-#{i}" }
disk = rows.map { |row| knot_hash(row) }.map { |hash|
  hash.each_slice(16).map { |bytes| "%08b" % bytes.reduce(:^) }.join
}.map { |row|
  row.chars.map { |c| c == '1' }
}

neigbors = [1.i, 1, -1.i, -1]
group = 0

disk.each_with_index { |row, i|
  row.each_with_index { |cell, j|
    if cell == true
      pos = Complex(j, i)
      disk[i][j] = (group += 1)

      stack = [pos]
      while pos = stack.pop
        neigbors.map { |neigbor| pos + neigbor }.select { |c|
          c.rect.all? { |v| v.between?(0, disk.size-1) }
        }.select { |c|
          disk[c.imag][c.real] == true
        }.each { |c|
          disk[c.imag][c.real] = group
          stack << c
        }
      end
    end
  }
}

puts disk.map { |row|
  row.map { |cell|
    cell ? (cell % 10) : '.'
  }.join
}

p group
