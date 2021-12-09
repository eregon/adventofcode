require_relative 'lib'

lines = File.readlines('5.txt', chomp: true).map { |line|
  line.split(' -> ').map { |coord|
    coord.split(',').map(&Integer).then {
      _1 + _2.i
    }
  }
}

lines = lines.select { |a,b| a.real == b.real or a.imag == b.imag }

crossings = Hash.new(0)
lines.each { |a,b|
  dir = b - a
  dir /= dir.abs
  Enumerator.produce(a) { _1 + dir }.find {
    crossings[_1] += 1
    _1 == b
  }
}

p crossings.values.count { _1 > 1 }
