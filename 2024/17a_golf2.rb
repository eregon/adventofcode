a,b,c,*p=$<.read.scan(/\d+/).map &:to_i;e=->x{x<4?x:[a,b,c][x-4]};o=i=0;eval'x=p[(i+=2)-1];'+%w[a>>=e[x] b^=x b=e[x]%8 a!=0&&i=x b^=c print(e[x]%8,?,) b=a>>e[x] c=a>>e[x]][o]while o=p[i]