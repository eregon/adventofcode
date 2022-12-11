require_relative 'lib'

Monkey = Struct.new(:items, :operation, :next, :inspected, keyword_init: true)

monkeys = File.read('11.txt').split("\n\n").map { |data|
  div = data[/Test: divisible by (\d+)$/, 1]
  Monkey.new(
    items: data[/Starting items: (.+)$/, 1].split(', ').map(&Int),
    operation: eval("-> old { #{data[/Operation: new = (.+)$/, 1]} }"),
    next: eval(<<~RUBY),
      -> n {
        if n % #{data[/Test: divisible by (\d+)$/, 1]} == 0
          #{data[/If true: throw to monkey (\d+)$/, 1]}
        else
          #{data[/If false: throw to monkey (\d+)$/, 1]}
        end
      }
    RUBY
    inspected: 0)
}

(1..20).each { |round|
  monkeys.each { |monkey|
    while item = monkey.items.shift
      item = monkey.operation.call(item)
      monkey.inspected += 1
      item /= 3
      throw_to = monkey.next.call(item)
      monkeys[throw_to].items << item
    end
  }
}

p monkeys.map(&:inspected).max(2).reduce(:*)
