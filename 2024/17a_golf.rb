a,b,c,*p=$<.read.scan(/\d+/).map &:to_i
e=->x{x<4?x:[a,b,c][x-4]}
o=i=0
# [->{a>>=e[it]},->{b^=it},->{b=e[it]%8},->{a!=0&&i=it},->_{b^=c},->{print"#{e[it]%8},"},->{b=a>>e[it]},->{c=a>>e[it]}][o][p[(i+=2)-1]]while o=p[i]
# eval("proc{#{%w[a>>=e[it] b^=it b=e[it]%8 a!=0&&i=it b^=c print"#{e[it]%8}," b=a>>e[it] c=a>>e[it]][o]}}")[p[(i+=2)-1]]while o=p[i]
# proc{it=_1;eval(%w[a>>=e[it] b^=it b=e[it]%8 a!=0&&i=it b^=c print"#{e[it]%8}," b=a>>e[it] c=a>>e[it]][o])}[p[(i+=2)-1]]while o=p[i]
# (z=p[(i+=2)-1];eval %w[a>>=e[z] b^=z b=e[z]%8 a!=0&&i=z b^=c print"#{e[z]%8}," b=a>>e[z] c=a>>e[z]][o])while o=p[i]
eval'z=p[(i+=2)-1];'+%w[a>>=e[z] b^=z b=e[z]%8 a!=0&&i=z b^=c print(e[z]%8,?,) b=a>>e[z] c=a>>e[z]][o]while o=p[i]