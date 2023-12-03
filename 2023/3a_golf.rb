s=$<.read
w=(s=~/$/)+1
s.scan(/\d+/){|n|$.+=n.to_i if Range.new(*$~.offset(0),1).any?{|i|[i-w,i,i+w].any?{(_1>0?s[_1-1,3]:s[_1,2])=~/[^\d\s.]/}}}
p $.