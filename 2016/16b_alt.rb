# frozen-string-literal: true

input = "10000"
length = 20

input = "10001001100000001"
length = 272
length = 35_651_584

def dragon(a)
  a + "0" + a.reverse.tr('10', '01')
end

def checksum(data)
  p data.size
  # out = String.new # (capacity: data.size / 2)
  out = " ".dup * (data.size / 2)
  i = 0
  while i < data.size
    # out << (data.getbyte(i) == data.getbyte(i+1) ? 49 : 48) # 16% faster
    # out << (data.getbyte(i) == data.getbyte(i+1) ? "1" : "0") # twice faster than below
    # out << (data[i] == data[i+1] ? "1" : "0")
    out[i >> 1] = (data[i] == data[i+1] ? "1" : "0") # SUPER SLOW on MRI
    i += 2
  end
  out
end

data = input
while data.size < length
  data = dragon(data)
end

data = data[0,length]

p :data

checksum = checksum(data)
while checksum.size.even?
  checksum = checksum(checksum)
end

p :checksum
p checksum
