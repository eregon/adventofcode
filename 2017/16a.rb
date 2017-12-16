input = File.read("16.txt").strip

moves = input.split(',')
programs = ('a'..'p').to_a

moves.each { |move|
  case move
  when /^s(\d+)$/ # spin
    programs.rotate!(-$1.to_i)
  when /^x(?<a>\d+)\/(?<b>\d+)$/ # exchange
    i, j = $~[:a].to_i, $~[:b].to_i
    programs[i], programs[j] = programs[j], programs[i]
  when /^p(?<a>\w+)\/(?<b>\w+)$/ # partner
    i = programs.index($~[:a])
    j = programs.index($~[:b])
    programs[i], programs[j] = programs[j], programs[i]
  else
    raise move
  end
}

puts programs.join
