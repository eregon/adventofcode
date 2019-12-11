input = File.readlines('3.txt')

class Complex
  def distance
    real.abs + imag.abs
  end
end

DIRS = { U: 1i, R: 1, D: -1i, L: -1 }
passing = Hash.new(0)

input.map.with_index { |wire, i|
  mask = 1 << i
  pos = 0 + 0i
  wire.chomp.split(',').each { |segment|
    dir = DIRS.fetch(segment[0].to_sym)
    n = Integer(segment[1..-1])
    n.times {
      pos += dir
      passing[pos] |= mask
    }
  }  
}

p passing.each_pair.select { |pos, count|
  count == 0b11
}.map(&:first).map(&:distance).min
