input = File.read("8.txt")
input2 = <<EOS
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
EOS

registers = Hash.new(0)
max_value = 0

code = input.strip.lines.map { |line|
  if /^(?<reg>\w+) (?<dir>inc|dec) (?<by>-?\d+) if (?<r>\w+) (?<cmp>[>=<!]+) (?<n>-?\d+)$/ =~ line
    by = by.to_i * (dir == "dec" ? -1 : 1)
    if registers[r].send(cmp, n.to_i)
      new_value = (registers[reg] += by)
      max_value = [new_value, max_value].max
    end
  else
    raise line
  end
}

p registers.values.max
p max_value
