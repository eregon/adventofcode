m=$<.read
w=(m=~/$/)
m.tr!"\n",''
s=m.index'S'
d={?L=>[1,-w],?J=>[-1,-w],?7=>[-1,w],?F=>[1,w],?-=>[-1,1],?|=>[-w,w]}
m[s]=d.key [1,-1,w,-w].filter_map{|e|e if d[m[s+e]]&.any? -e}
p=s+d[m[s]][0];z=[s,p];loop{a,b=d[m[p]];p+=z.any?(p+a)?b:a;break if z.any?(p);z<<p};p z.size/2