input = 368078

max = 1
side = 0
while input > max
  max += (side += 2) * 4
end

prev_max = (side-2+1)**2
east_value = (prev_max + side/2)
dist_from_east = (east_value - input).abs % side
p side/2 + [ dist_from_east, side - dist_from_east ].min
