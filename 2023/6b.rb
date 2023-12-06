time, record = $<.readlines.map { |line| line.scan(/\d+/).reduce(:+).to_i }
p (1...time).count { |t|
  (time - t) * t > record
}
