p$<.sum{e,*n=it.split(/\D+/).map &:to_i;%i[+ *].repeated_permutation(n.size-1).any?{|o|n.inject{_1.send o.shift,_2}==e}?e:0}