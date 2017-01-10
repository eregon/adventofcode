disks = ARGF.readlines.map { |line|
  /Disc #(\d+) has (\d+) positions; at time=0, it is at position (\d+)./ =~ line
  raise line unless $~
  dt, n, pos = $~.captures.map { |i| Integer(i) }
}

p (0..Float::INFINITY).find { |t|
  disks.all? { |dt, n, pos|
    (t + pos + dt) % n == 0
  }
}
