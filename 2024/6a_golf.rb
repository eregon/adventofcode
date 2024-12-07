e=[d=-(w=((m=$<.read)=~/$/)+1),1,w,-1].cycle
p=m.index'^'
ok=->c{m[c]if c>=0&&m[c]!=?\n}
(m[p]=?X;d=e.next while ok[p+d]==?#;p+=d)while ok[p]
p m.count'X'