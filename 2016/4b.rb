ARGF.each_line { |line|
  line.chomp!
  *name, id_checksum = line.split('-')
  id, checksum = id_checksum.sub(/\]$/, '').split('[')
  id = Integer(id)
  letters = name.join
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
    name = name.join(' ')
    decrypted = name.chars.map { |c|
      if c == ' '
        c
      else
        raise unless 'a' <= c and c <= 'z'
        (((c.ord - 'a'.ord) + id) % 26 + 'a'.ord).chr
      end
    }.join
    if decrypted =~ /north/
      puts decrypted
      p id
    end
  end
}
