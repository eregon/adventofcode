in_memory = 0
in_source = 0

STDIN.each_line { |line|
  line.strip!
  in_source += line.size
  str = line
  in_memory += str.inspect.size
}

p in_memory - in_source
