M = {
  "a" => 0,
  "b" => 0,
  "c" => 0,
  "d" => 0,
}
R = /[abcd]/

commands = ARGF.readlines.map(&:chomp)
max = commands.size
pc = 0

while pc < max
  command = commands[pc]
  opc = pc
  pc += 1
  case command
  when /^cpy (\d+|#{R}) (#{R})$/
    src, dst = $1, $2
    val = R =~ src ? M[src] : src.to_i
    M[dst] = val
  when /^inc (#{R})$/
    M[$1] += 1
  when /^dec (#{R})$/
    M[$1] -= 1
  when /^jnz (\d+|#{R}) (-?\d+)$/
    test, move = $1, $2
    val = R =~ test ? M[test] : test.to_i
    unless val == 0
      pc = opc + move.to_i
    end
  else
    raise command
  end
end

p M["a"]
