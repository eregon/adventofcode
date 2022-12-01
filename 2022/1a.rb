require_relative 'lib'

elfs = File.read('1.txt').split("\n\n").map { |elf| elf.lines.map(&Integer) }
p elfs.max_by(&:sum).sum
