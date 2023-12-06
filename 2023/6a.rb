races = $<.readlines.map { |line| line.scan(/\d+/).map(&:to_i) }.reduce(:zip)
p races.map { |time, record|
  (1...time).count { |t|
    (time - t) * t > record
  }
}.reduce(:*)
