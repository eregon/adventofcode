p File.readlines('1.txt').sum { /(\d)(?:.*(\d))?/ =~ _1 and ($1 + ($2 || $1)).to_i }
