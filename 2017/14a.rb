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
  row.tr("01", ".#")
}.join("\n")

puts disk
p disk.count("#")
