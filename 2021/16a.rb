require_relative 'lib'

bits = File.read('16.txt').chomp.chars.map { "%04b" % Integer(_1, 16) }.join.freeze

index = 0
read = -> n_bits {
  bits[index...(index += n_bits)]
}

int = -> n_bits {
  Integer(read[n_bits], 2)
}

sum = 0

parse = -> {
  version = int[3]
  sum += version

  type = int[3]
  case type
  when 4 # read number
    parts = ''
    begin
      last = int[1]
      parts << read[4]
    end until last == 0
  else
    if int[1] == 0
      bit_length = int[15]
      start = index
      parse[] while index < start + bit_length
      raise unless index == start + bit_length
    else
      n_packets = int[11]
      n_packets.times { parse[] }
    end
  end
}

parse[]
p sum
