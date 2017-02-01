# 123 -> x
# 456 -> y
# x AND y -> d
# x OR y -> e
# x LSHIFT 2 -> f
# y RSHIFT 2 -> g
# NOT x -> h
# NOT y -> i

class Future < BasicObject
  def initialize(&block)
    @block = block
  end

  def reset
    @value = nil
  end

  def value
    @value ||= @block.call
  end

  def method_missing(meth, *args, &block)
    value.send(meth, *args, &block)
  end
end

def thread(&block)
  Future.new(&block)
end

D = {}

def input_or_number(v)
  i = Integer(v)
  thread { i }
rescue
  D[v]
end

STDIN.each_line { |line|
  if /^(?<a>\w+) -> (?<r>\w+)$/ =~ line
    D[r] = thread { +input_or_number(a) }
  elsif /^NOT (?<a>\w+) -> (?<r>\w+)$/ =~ line
    D[r] = thread { ~input_or_number(a) }
  elsif /^(?<a>\w+) (?<op>AND|OR|LSHIFT|RSHIFT) (?<b>\w+) -> (?<r>\w+)$/ =~ line
    op = {'AND' => :&, 'OR' => :|, 'LSHIFT' => :<<, 'RSHIFT' => :>>}[op]
    D[r] = thread { input_or_number(a).send(op, input_or_number(b)) }
  end
}

a = +D['a']
p a

D.each_value(&:reset)
D['b'] = a
p +D['a']
