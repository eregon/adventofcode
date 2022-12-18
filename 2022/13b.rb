require_relative 'lib'

packets = File.read('13.txt').split("\n\n").flat_map { |pair| pair.lines.map { eval _1 } }
extra = [[[2]], [[6]]]
packets += extra

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

packets.sort! { |a, b|
  case compare(a, b)
  in true then -1
  in false then 1
  in nil then 0
  end
}

p extra.map { packets.index(_1) + 1 }.reduce(:*)
