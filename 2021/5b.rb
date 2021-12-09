require_relative 'lib'

lines = File.readlines('5.txt', chomp: true).map { |line|
  line.split(' -> ').map { |coord|
    coord.split(',').map(&Integer).then {
      _1 + _2.i
    }
  }
}

crossings = Hash.new(0)
lines.each { |a,b|
  dir = b - a
  dir /= [(b.real - a.real).abs, (b.imag - a.imag).abs].max
  pos = a
  Enumerator.produce(a) { _1 + dir }.find {
    crossings[_1] += 1
    _1 == b
  }
}

p crossings.values.count { _1 > 1 }
