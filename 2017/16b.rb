input = File.read("16.txt").strip

moves = input.split(',')
programs = ('a'..'p').to_a

compiled_moves = moves.map { |move|
  case move
  when /^s(\d+)$/ # spin
    by = -$1.to_i
    -> {
      programs.rotate!(by)
    }
  when /^x(?<a>\d+)\/(?<b>\d+)$/ # exchange
    i, j = $~[:a].to_i, $~[:b].to_i
    -> {
      programs[i], programs[j] = programs[j], programs[i]
    }
  when /^p(?<a>\w+)\/(?<b>\w+)$/ # partner
    a, b = $~[:a], $~[:b]
    -> {
      i = programs.index(a)
      j = programs.index(b)
      programs[i], programs[j] = programs[j], programs[i]
    }
  end
}.freeze

10_000.times do |i|
  puts "#{i}\t" + programs.join if i % 100 == 0
  compiled_moves.each { |move| move.call }
end

puts programs.join
