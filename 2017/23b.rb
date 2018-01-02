# Solved by disassembling the input to Ruby code and manually optimizing

# The program actually counts the non-prime numbers amongst
# 106_500, +17, +34, ..., 123_500
require 'prime'
p (106_500..123_500).step(17).count { |e| !Prime.prime?(e) }

a = 1
h = 0

A = 1
b = 106_500
C = 123_500

loop do
  f = 1
  d = 2
  begin

    # e = 2
    # begin
    #   f = 0 if d * e == b
    #   e += 1
    # end while e != b

    # Optimized to:
    e = b
    # Check if b is the product of 2 integers, both >= 2,
    # i.e., if it is not a prime number
    f = 0 if b % d == 0 and div = b / d and div.between?(2, e-1)

    d += 1
  end while d != b

  h += 1 if f == 0
  break if b == C
  b += 17
end

p h
