distances = Hash.new { |h,k| h[k] = {} }

STDIN.each_line { |line|
  raise unless /(?<from>\w+) to (?<to>\w+) = (?<dist>\d+)/ =~ line
  distances[from][to] = distances[to][from] = Integer(dist)
}

DIST = -> perm { perm.each_cons(2).inject(0) { |d,(a,b)| d + distances[a][b] } }
path = distances.keys.permutation.max_by(&DIST)

p path
p DIST[path]
