input = File.read('8.txt').chomp
width = 25
height = 6
n_pixels = width * height
raise unless input.size % n_pixels == 0
layers = input.chars.map { |c| Integer(c) }.each_slice(n_pixels).to_a
layer = layers.min_by { |layer| layer.count(0) }
p layer.count(1) * layer.count(2)
