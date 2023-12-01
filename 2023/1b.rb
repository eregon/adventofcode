digits = (%w[one two three four five six seven eight nine].zip(1..9) + ('0'..'9').zip(0..9)).to_h
digit = digits.keys.join '|'
p File.readlines('1.txt').sum { /(#{digit})(?:.*(#{digit}))?/o =~ _1 and digits[$1] * 10 + digits[$2 || $1] }
