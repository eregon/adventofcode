p$<.sum{|l|r=[s=l.split.map(&:to_i)];r<<s=s.each_cons(2).map{_2-_1}until s.all?0;r.sum(&:last)}