fields, mine, others = File.read('16.txt').split("\n\n")
valid = fields.scan(/(\d+)-(\d+)/).map { |from, to| (from.to_i..to.to_i) }
p others.scan(/\d+/).map(&:to_i).select { |n| valid.none? { |range| range === n } }.sum
