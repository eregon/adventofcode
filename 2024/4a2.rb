def overlapping_scan(string, regexp)
  offset = 0
  matches = []
  while m = regexp.match(string, offset)
    matches << m
    offset = m.begin(0) + 1
  end
  matches
end

c = $<.read
w = c.lines.first.size
regexps = [
  /XMAS/,
  /SAMX/,
  *(-2..0).flat_map {
    [
      /X.{#{w+it}}M.{#{w+it}}A.{#{w+it}}S/m,
      /S.{#{w+it}}A.{#{w+it}}M.{#{w+it}}X/m
    ]
  }
]
p regexps.sum {
  overlapping_scan(c, it).size
}