actions = File.readlines('2.txt').map { |line|
  line.split.then { [_1, Integer(_2)] }
}

x, depth = 0, 0
actions.each { |action, n|
  case action
  in 'forward' then x += n
  in 'down' then depth += n
  in 'up' then depth -= n
  end
}
p x * depth
