b,g=$<.map{_1.chomp.chars},[];2.times{((b=b.transpose).size-1).downto(0){|i|b[i,0]=[b[i]]if b[i].all? ?.}};b.zip(0..){|r,y|r.zip(0..){g<<_2+y.i if _1==?#}};p g.combination(2).sum{(_1-_2).rect.sum(&:abs)}