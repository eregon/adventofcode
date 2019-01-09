a = Integer(ARGV[0] || 1)
b, c, d, e = 0, 0, 0, 0

b = (b + 2)*(b + 2) * 19 * 11
c = (c + 2) * 22 + 20
b += c

unless a == 0
  c = 27 if a <= 1
  c *= 28 if a <= 2
  c += 29 if a <= 3
  c *= 30 if a <= 4
  c *= 14 if a <= 5
  c *= 32 if a <= 6
  b += c if a <= 7
  a = 0 if a <= 8

  if a >= 10
    p "a >= 10"
    p [a, b, c, d, e]
    exit
  end
end

p [:ending, a, b, c]

(1..b).each { |e|
  # (1..b).each { |d|
  (1..b/e).each { |d|
    if e * d == b
      a += e
    end
  }
}

p [a, b, c, d, e]
