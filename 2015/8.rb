in_memory = 0
in_source = 0

STDIN.each_line { |line|
  line.strip!
  in_source += line.size
  str = eval(line)
  in_memory += str.size
}

p in_source - in_memory
