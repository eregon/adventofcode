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
  crossings[pos] += 1
  until pos == b
    pos += dir
    crossings[pos] += 1
  end
}

p crossings.values.count { _1 > 1 }
