n = 5
n = 500
# n = 3_001_330

a = Array.new(n, true)

m = n
i = 0
pred = i
while m > 1
  pred = i
  d = m / 2
  while d > 0
    i = (i+1) % n
    d -=1 if a[i]
  end
  a[i] = false
  i = (i+1) % n until a[i]
  m -= 1
end

p pred+1
