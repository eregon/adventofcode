fields, mine, others = File.read('16.txt').split("\n\n")

fields = fields.lines.map { |line|
  name = line[/^([\w ]+):/, 1]
  [name, line[/^[\w ]+: ((\d+-\d+)( or \d+-\d+)*)$/, 1].split(' or ').map { |range|
    range =~ /(\d+)-(\d+)/ and ($1.to_i..$2.to_i)
  }]
}
valid = fields.flat_map(&:last)

mine = mine.lines.drop(1)[0].chomp.split(',').map(&:to_i)

tickets = others.lines.drop(1).map { |line|
  line.chomp.split(',').map(&:to_i)
}.reject { |ticket|
  ticket.any? { |n| valid.none? { |range| range === n } }
}

to_assign = fields.dup
assignment = [nil] * fields.size
until to_assign.empty?
  assignment.each_with_index { |assigned,i|
    next if assigned
    data = tickets.map { |ticket| ticket[i] }
    matching_fields = to_assign.select { |name, ranges|
      data.all? { |n| ranges.any? { |range| range === n } }
    }

    if matching_fields.size == 1
      assignment[i] = to_assign.delete(matching_fields.first)
    end
  }
end

indices = assignment.map(&:first).map.with_index.to_a.select { |name,_| /^departure/ =~ name }.map(&:last)
p mine.values_at(*indices).reduce(:*)
