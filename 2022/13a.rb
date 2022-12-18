require_relative 'lib'

pairs = File.read('13.txt').split("\n\n").map { |pair| pair.lines.map { eval _1 } }

def compare(a, b)
  case [a, b]
  in [Integer, Integer]
    return true if a < b
    return false if a > b
    nil
  in [Array, Array]
    a += [nil] * (b.size - a.size) if a.size < b.size
    a.zip(b) { |c,d|
      case [c, d]
      in [nil, _]
        return true
      in [_, nil]
        return false
      else
        v = compare(c, d)
        return v unless v.nil?
      end
    }
    nil
  in [Integer, Array]
    compare([a], b)
  in [Array, Integer]
    compare(a, [b])
  end
end

p pairs.each.with_index(1).sum { |(a,b), i|
  (i if compare(a, b)).to_i
}
