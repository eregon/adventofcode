input = "10000"
length = 20

input = "10001001100000001"
length = 272

def dragon(a)
  a + "0" + a.reverse.tr('10', '01')
end

def checksum(data)
  data.chars.each_slice(2).map { |a,b|
    a == b ? "1" : "0"
  }.join
end

data = input
while data.size < length
  data = dragon(data)
end

data = data[0,length]

p data

checksum = checksum(data)
while checksum.size.even?
  checksum = checksum(checksum)
end

p checksum
