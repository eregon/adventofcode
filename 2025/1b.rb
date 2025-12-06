zeros = 0
dial = 50
$<.each {
  step = it[0] == 'L' ? -1 : +1
  it[1..].to_i.times {
    dial = (dial + step) % 100
    zeros += 1 if dial == 0
  }
}
p zeros
