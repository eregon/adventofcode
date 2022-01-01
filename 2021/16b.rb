require_relative 'lib'

bits = File.read('16.txt').chomp.chars.map { "%04b" % Integer(_1, 16) }.join.freeze

index = 0
read = -> n_bits {
  bits[index...(index += n_bits)]
}

int = -> n_bits {
  Integer(read[n_bits], 2)
}

operations = [:+, :*, :min, :max, nil, :>, :<, :==]

parse = -> {
  version = int[3]
  type = int[3]

  case type
  when 4 # read number
    parts = ''
    begin
      last = int[1]
      parts << read[4]
    end until last == 0
    parts.to_i(2)
  else
    if int[1] == 0
      bit_length = int[15]
      start = index
      args = []
      args << parse[] while index < start + bit_length
      raise unless index == start + bit_length
    else
      n_packets = int[11]
      args = n_packets.times.map { parse[] }
    end

    [operations.fetch(type), *args]
  end
}

interpret = -> code {
  case code
  when Integer
    code
  else
    operation, *args = code
    args = args.map { interpret[_1] }
    case operation
    when :min, :max
      args.send(operation)
    else
      # !!r != r ? r : r ? 1 : 0
      case args.reduce(operation)
      in Integer => i then i
      in true then 1
      in false then 0
      end
    end
  end
}

code = parse[]
# pp code
p interpret[code]

