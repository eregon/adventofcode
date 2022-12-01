require_relative 'lib'

elfs = File.read('1.txt').split("\n\n").map { _1.lines.map(&Int) }
p elfs.max_by(&:sum).sum
