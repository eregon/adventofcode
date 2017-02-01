p ARGF.readlines.map(&:chomp).inject(0) { |total,box|
  l, w, h = box.split('x').map { |e| Integer(e) }
  surfaces = [l*w, w*h, h*l]
  total + 2 * surfaces.reduce(:+) + surfaces.min
}
