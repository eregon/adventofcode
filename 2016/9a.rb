input = "X(8x2)(3x3)ABCY"
input = ARGF.read.chomp

i = 0
decompressed = ""
while i < input.length
  c = input[i]
  if c == "("
    i += 1
    ahead = input[i..-1]
    ahead =~ /^(\d+)x(\d+)\)/
    raise ahead unless $~
    # i = input.index(')', i) + 1
    i += $&.size
    chars, times = Integer($1), Integer($2)
    decompressed << input[i,chars] * times
    i += chars
  else
    decompressed << c
    i += 1
  end
end

puts decompressed
puts decompressed.size
