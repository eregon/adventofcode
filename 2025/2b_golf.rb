r=Set[]
$<.read.strip.split(?,).flat_map{
a,b=it.split(?-)
(s=a.size)==b.size ? [[a,b]]:[[a,?9*s],[?1+?0*s,b]]
}.each{|a,b|
  s=a.size
  (1..s/2).each{|z|
    if s%z==0
      (a[0,z]..b[0,z]).each{
        n=it*(s/z)
        r << n.to_i if (a..b).cover? n
      }
    end
  }
}
p r.sum
