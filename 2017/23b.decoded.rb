b = 65
c = b
if a == 0 # jump + 2 if a != 0
  jump + 5; end
b *= 100
b += 100_000
c = b
c += 17_000
loop do;f = 1
d = 2
begin; e = 2
begin; g = d
g *= e
g -= b
if g == 0; # jump + 2 if g != 0
  f = 0; end
e += 1
g = e
g -= b
end while g != 0 # jump -8 if g != 0
d += 1
g = d
g -= b
end while g != 0 # jump - 13 if g != 0
if f == 0 # jump + 2 if f != 0
  h += 1; end
g = b
g -= c
if g == 0 # jump + 2 if g != 0
  exit; end # jump + 3
b += 17
end # jump -23
