f = 0
p (ARGF.read.strip.each_char.find_index { |c|
  f += { '(' => 1, ')' => -1 }[c]
  f == -1
}+1)
