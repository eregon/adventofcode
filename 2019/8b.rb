input = File.read('8.txt').chomp
width = 25
height = 6
n_pixels = width * height
raise unless input.size % n_pixels == 0
layers = input.chars.map { |c| Integer(c) }.each_slice(n_pixels).to_a
image = n_pixels.times.map { |i|
  layers.find { |layer| layer[i] != 2 }[i]
}
puts image.map { |e| e == 1 ? '#' : ' ' }.each_slice(width).map { |row| row.join }
