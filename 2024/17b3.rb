_, _, _, *program = $<.read.scan(/\d+/).map(&:to_i)

compiled = []

compiled << <<~RUBY.chomp
def run(n)
  a = n
  b, c = 0, 0
  ip = 0
  out = []
  -> {
RUBY

combo = -> x {
  case x
  in 0..3 then x
  in 4 then "a"
  in 5 then "b"
  in 6 then "c"
  end
}

program.each_slice(2) { |opcode, x|
  compiled << " " * 4 + case %i[adv bxl bst jnz bxc out bdv cdv][opcode]
  in :adv then "a = a / (2 ** #{combo[x]})"
  in :bxl then "b ^= #{x}"
  in :bst then "b = #{combo[x]} % 8"
  in :jnz then
    raise "jnz #{x}" unless x == 0
    "redo unless a == 0"
  in :bxc then "b ^= c"
  in :out then "out << #{combo[x]} % 8"
  in :bdv then "b = a / (2 ** #{combo[x]})"
  in :cdv then "c = a / (2 ** #{combo[x]})"
  end
}

compiled << <<~RUBY
  }.()
  out
end
RUBY

compiled = compiled.join("\n")

puts compiled
eval compiled

$n = 0

Thread.new {
  loop {
    sleep 1
    p $n
  }
}

p (0..).find { |n|
  $n = n
  run(n) == program
}
