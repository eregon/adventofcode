n = 5
n = 3_001_330

a = Array.new(n, true)

m = n
i = 0
pred = i
while m > 1
  pred = i
  i = (i+1)%n
  i = (i+1)%n until a[i]
  a[i] = false
  i = (i+1)%n until a[i]
  m -= 1
end

p pred+1
