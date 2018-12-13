MIN_X, MAX_X = -250, 749
MIN_Y, MAX_Y = -250, 349
RANGE_X = MIN_X..MAX_X
RANGE_Y = MIN_Y..MAX_Y

HEIGHT = MAX_Y - MIN_Y + 1
WIDTH = MAX_X - MIN_X + 1

Star = Struct.new(:position, :velocity) do
  def advance!
    self.position += self.velocity
  end
end

def view(img)
  unless @mplayer
    @mplayer = IO.popen('mplayer -really-quiet -noframedrop - 2>/dev/null', 'wb')
    @mplayer.puts("YUV4MPEG2 W#{WIDTH} H#{HEIGHT} F30:1 Ip A1:1")
    @color_data = 127.chr * (WIDTH * HEIGHT / 2)
  end
  raise unless WIDTH == img[0].size and HEIGHT == img.size
  @mplayer.write "FRAME\n"
  img.each { |row|
    @mplayer.write(row.pack('C*'))
  }
  @mplayer.write @color_data
end

stars = File.readlines("10.txt", chomp: true).map { |line|
  x, y, vx, vy = line.scan(/-?\d+/).map(&:to_i)
  Star.new(x + y.i, vx + vy.i)
}

def visualize(stars)
  img = Array.new(HEIGHT) {
    Array.new(WIDTH, 0)
  }
  stars.each { |star|
    pos = star.position
    if RANGE_X.include?(pos.real) and RANGE_Y.include?(pos.imag)
      img[pos.imag-MIN_Y][pos.real-MIN_X] = 255
    end
  }

  view(img)
end

visualize(stars)

20_000.times do |i|
  p i
  positions = stars.map(&:position)
  if (positions.map(&:real).sum(&:abs) / positions.size.to_f) < 300
    visualize(stars)
    gets
  end

  stars.each(&:advance!)
end
