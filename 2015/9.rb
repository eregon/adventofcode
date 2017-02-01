distances = Hash.new { |h,k| h[k] = {} }

STDIN.each_line { |line|
  raise unless /(?<from>\w+) to (?<to>\w+) = (?<dist>\d+)/ =~ line
  distances[from][to] = distances[to][from] = Integer(dist)
}

cities = distances.keys

min_distance = Float::INFINITY
min_path = nil

cities.permutation { |perm|
  d = perm.each_cons(2).inject(0) { |d,(a,b)| d + distances[a][b] }
  if d < min_distance
    min_distance = d
    min_path = perm.dup
  end
}

p min_path
p min_distance
