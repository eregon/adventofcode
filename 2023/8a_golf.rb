m,_,*r=*$<
m=m.chop.bytes.cycle
r=r.to_h{a,*b=_1.scan /\w+/;[a,b]}
p Enumerator.produce(?A*3){|c|r[c][m.next/82]}.find_index"ZZZ"