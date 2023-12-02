max = %w[red green blue].zip(12..14).to_h
p File.readlines('2.txt').sum { |line|
  game = line[/^Game (\d+): (.+)$/, 1].to_i
  $2.split('; ').all? { |pick|
    pick.split(', ').all? {
      _1[/^(\d+) (\w+)$/]
      $1.to_i <= max.fetch($2)
    }
  } ? game : 0
}
