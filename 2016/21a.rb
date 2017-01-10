str = "deabc" # "abcde"
# str = "abcdefgh"

ARGF.each_line { |line|
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
    str = str.chars.rotate(i).join
  when /^rotate right \d+ steps?$/
    str = str.chars.rotate(-i).join
  when /^move position \d+ to position \d+$/
    l = str[i]
    str[i..i] = ""
    str.insert(j, l)
  when /^rotate based on position of letter ([a-z])$/
    raise unless i = str.index($1)
    rot = 1+i
    rot += 1 if i >= 4
    str = str.chars.rotate(-rot).join
  else
    raise line
  end
}
p str
