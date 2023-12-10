m={}
$<.zip(1..){|r,y|r.chars.zip(1..){|c,x|m[x+y.i]=c if c!=?.}}
d={?L=>[1,-1i],?J=>[-1,-1i],?7=>[-1,1i],?F=>[1,1i],?-=>[-1,1],?|=>[-1i,1i]}
s=m.key'S'
m[s]=d.key [1,-1,1i,-1i].filter_map{|e|e if d[m[s+e]]&.any? -e}
o,c=s,1
p=s+d[m[s]][0]
until p==s
a,b=d[m[p]]
g=p+a!=o ?a:b
o=p
p+=g
c+=1
end
p c/2