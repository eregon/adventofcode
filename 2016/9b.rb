input = "(3x3)XYZ"
input = "X(8x2)(3x3)ABCY"
input = "(27x12)(20x12)(13x14)(7x10)(1x12)A"
input = "(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN"
input = ARGF.read.chomp

def decompress(input)
  i = 0
  decompressed = 0
  while i < input.length
    c = input[i]
    if c == "("
      i += 1
      ahead = input[i..-1]
      ahead =~ /^(\d+)x(\d+)\)/
      raise ahead unless $~
      i +=10 $&.size
      chars, times = Integer($1), Integer($2)
      slice = input[i,chars]
      decompressed += times * decompress(slice)
      i += chars
    else
      decompressed += 1
      i += 1
    end
  end
  decompressed
end

p decompress(input)
