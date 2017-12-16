input = File.read("16.txt").strip
moves = input.split(',')

code = []
code << "def dance(programs)"
moves.each { |move|
  case move
  when /^s(\d+)$/ # spin
    by = -$1.to_i
    code << "  programs.rotate!(#{by})"
  when /^x(?<a>\d+)\/(?<b>\d+)$/ # exchange
    i, j = $~[:a].to_i, $~[:b].to_i
    code << "  programs[#{i}], programs[#{j}] = programs[#{j}], programs[#{i}]"
  when /^p(?<a>\w+)\/(?<b>\w+)$/ # partner
    a, b = $~[:a], $~[:b]
    code << "  i = programs.index(#{a.inspect})"
    code << "  j = programs.index(#{b.inspect})"
    code << "  programs[i], programs[j] = programs[j], programs[i]"
  else
    raise move
  end
}
code << "  programs"
code << "end"

eval(code.join("\n"))

programs = ('a'..'p').to_a

10_000.times do |i|
  if i % 100 == 0
    puts "#{i}\t" + programs.join
  end
  programs = dance(programs)
end

puts programs.join
