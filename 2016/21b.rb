str = "decab"
str = "fbgdceah"

ARGF.readlines.reverse_each { |line|
  puts str
  line.chomp!
  i, j = line.scan(/\d+/).map(&:to_i)
  case line
  when /^swap position \d+ with position \d+$/
    str[i], str[j] = str[j], str[i]
  when /^swap letter ([a-z]) with letter ([a-z])$/
    str.tr!($1+$2, $2+$1)
  when /^reverse positions \d+ through \d+$/
    chars = str.chars
    raise unless i < j
    chars[i..j] = chars[i..j].reverse
    str = chars.join
  when /^rotate left \d+ steps?$/
    str = str.chars.rotate(-i).join
  when /^rotate right \d+ steps?$/
    str = str.chars.rotate(i).join
  when /^move position \d+ to position \d+$/
    l = str[j]
    str[j..j] = ""
    str.insert(i, l)
  when /^rotate based on position of letter ([a-z])$/
    # ABCDE c BCDEA DEABC
    l = $1
    # search r such that apply(str.rotate(r)) == str
    r = (0...str.size).find { |r|
      s = str.chars.rotate(r).join
      raise unless i = s.index(l)
      rot = 1+i
      rot += 1 if i >= 4
      s2 = s.chars.rotate(-rot).join
      s2 == str
    }
    str = str.chars.rotate(r).join
  else
    raise line
  end
}
p str
