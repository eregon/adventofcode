fields, mine, others = File.read('16.txt').split("\n\n")

valid = fields.lines.flat_map { |line|
  line[/^[\w ]+: ((\d+-\d+)( or \d+-\d+)*)$/, 1].split(' or ').map { |range|
    range =~ /(\d+)-(\d+)/ and ($1.to_i..$2.to_i)
  }
}

p others.lines.drop(1).flat_map { |line|
  line.chomp.split(',').map(&:to_i)
}.select { |n| valid.none? { |range| range === n } }.sum
