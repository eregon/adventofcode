sum = 0
ARGF.each_line { |line|
  line.chomp!
  *letters, id_checksum = line.split('-')
  id, checksum = id_checksum.sub(/\]$/, '').split('[')
  id = Integer(id)
  letters = letters.join
  counts = Hash.new(0)
  letters.each_char { |letter| counts[letter] += 1 }
  best_counts = counts.values.sort.reverse[0...5].uniq
  check = ""
  best_counts.each { |c|
    matching = counts.select { |k,v| v == c }.map(&:first).sort
    while check.size < 5 and l = matching.shift
      check << l
    end
  }
  # p [line, check, checksum]
  if check == checksum
    sum += id
  end
}
p sum
