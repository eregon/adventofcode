d=50;n=0
$<.map{eval"d#{it.sub(?L,'-=').sub(?R,'+=')};n+=1 if d%100==0"}
p n