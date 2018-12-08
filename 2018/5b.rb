polymer = File.read("5.txt").chomp.chars.freeze

def react?(a, b)
  a.downcase == b.downcase && a != b
end

def react(polymer)
  cur = 0
  while i = (cur...polymer.size-1).find { |i| react?(polymer[i], polymer[i+1]) }
    polymer = polymer[0...i] + polymer[i+2..-1]
    cur = (i-1).clamp(0, polymer.size-1)
  end
  polymer
end

p polymer.map(&:downcase).uniq.sort.map { |type|
  without = polymer.dup
  without.delete(type)
  without.delete(type.upcase)
  react(without).size
}.min
