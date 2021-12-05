actions = File.readlines('2.txt').map { |line|
  line.split.then { [_1, Integer(_2)] }
}

x, depth, aim = 0, 0, 0
actions.each { |action, n|
  case action
  in 'forward' then x += n and depth += aim * n
  in 'down' then aim += n
  in 'up' then aim -= n
  end
}
p x * depth
