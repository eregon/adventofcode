input = File.read("11.txt").strip
path = input.split(",").map(&:to_sym)

DELTAS = {
  n:  0+1.i,
  ne: 1+0.i,
  se: 1-1.i,
  s:  0-1.i,
  sw: -1+0.i,
  nw: -1+1.i,
}

def distance(a, b)
  steps = DELTAS.values
  cur = a
  dist = 0
  until cur == b
    cur += steps.min_by { |step|
      (cur + step - b).abs
    }
    dist += 1
  end
  dist
end

initial = 0+0.i
pos = initial

p path.map { |step|
  pos += DELTAS[step]
  distance(initial, pos)
}.max

p pos
p distance(0+0.i, pos)
