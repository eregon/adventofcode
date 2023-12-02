p File.readlines('2.txt').sum { |line|
  max = %w[red green blue].zip([0] * 3).to_h
  line[/: (.+)$/, 1].split('; ').each { |pick|
    pick.split(', ').each {
      _1[/^(\d+) (\w+)$/]
      max[$2] = [max[$2], $1.to_i].max
    }
  }
  max.values.reduce(:*)
}
