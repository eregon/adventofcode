p ARGF.read.strip.each_char.inject(0) { |f,c| f + { '(' => 1, ')' => -1 }[c] }
