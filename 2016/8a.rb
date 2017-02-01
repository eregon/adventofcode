h, w = 6, 50 # 3, 7
screen = Array.new(h) { Array.new(w) { '.' } }

ARGF.each_line { |command|
  case command
  when /^rect (\d+)x(\d+)$/
    a, b = Integer($1), Integer($2)
    b.times { |y| screen[y][0...a] = ['#']*a }
  when /^rotate row y=(\d+) by (\d+)$/
    y, n = Integer($1), Integer($2)
    screen[y].rotate!(-n)
  when /^rotate column x=(\d+) by (\d+)$/
    x, n = Integer($1), Integer($2)
    screen = screen.transpose.tap { |t| t[x].rotate!(-n) }.transpose
  else
    raise command
  end
  sleep 0.05
  puts
  screen.each { |row| puts row.join }
}

p screen.flat_map(&:itself).count('#')
