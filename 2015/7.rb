# 123 -> x
# 456 -> y
# x AND y -> d
# x OR y -> e
# x LSHIFT 2 -> f
# y RSHIFT 2 -> g
# NOT x -> h
# NOT y -> i

data = {}

def input_or_number(v)
  Integer(v)
rescue
  v
end

STDIN.each_line { |line|
  line.chomp!
  if /^(?<input>\w+) -> (?<var>\w+)$/ =~ line
    data[var] = [:+@, input_or_number(input)]
  elsif /^NOT (?<a>\w+) -> (?<r>\w+)$/ =~ line
    data[r] = [:~, input_or_number(a)]
  elsif /^(?<a>\w+) (?<op>AND|OR|LSHIFT|RSHIFT) (?<b>\w+) -> (?<r>\w+)$/ =~ line
    op = {'AND' => :&, 'OR' => :|, 'LSHIFT' => :<<, 'RSHIFT' => :>>}[op]
    data[r] = [op, input_or_number(a), input_or_number(b)]
  end
}

def solve(data, var)
  p [[var]]
  val = data[var]
  case val
  when Integer
    val
  when Array
    (1...val.size).each { |i|
      p val[i]
      val[i] = solve(data, val[i]) unless Integer === val[i]
    }
    op, *inputs = val
    p val
    p [op,inputs]
    data[var] = inputs[0].send(op, *inputs[1..-1]) & 65535
  else
    raise var.inspect
  end
end

p solve(data, ARGV[0] || 'a')

