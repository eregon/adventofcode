input = File.readlines('3.txt')

class Complex
  def distance
    real.abs + imag.abs
  end
end

DIRS = { U: 1i, R: 1, D: -1i, L: -1 }
passing = Hash.new { |h,k| h[k] = [nil] * input.size }

input.map.with_index { |wire, i|
  pos = 0 + 0i
  steps = 0
  wire.chomp.split(',').each { |segment|
    dir = DIRS.fetch(segment[0].to_sym)
    n = Integer(segment[1..-1])
    n.times {
      pos += dir
      steps += 1
      passing[pos][i] ||= steps
    }
  }  
}

p passing.each_pair.select { |pos, steps|
  steps.all?
}.min_by { |pos, steps| steps.sum }.last.sum
