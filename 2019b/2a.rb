code = $<.read.split(',').map(&:to_i)

code[1] = 12
code[2] = 2

code.each_slice(4) { |opcode, a, b, r|
  case opcode
  in 1
    code[r] = code[a] + code[b]
  in 2
    code[r] = code[a] * code[b]
  in 99
    break
  end
}

p code[0]
