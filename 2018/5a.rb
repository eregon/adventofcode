polymer = File.read("5.txt").chomp.chars

def react?(a, b)
  a.downcase == b.downcase && a != b
end

while i = polymer.each_cons(2).find_index { |a,b| react?(a,b) }
  polymer = polymer[0...i] + polymer[i+2..-1]
  # polymer[i..i+1] = []
end

p polymer.size
