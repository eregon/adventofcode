r=[]
$<.read.chomp.split(?,).map{
  a,b=it.split ?-
  a=?1+?0*a.size if a.size.odd?
  b=?9*(b.size-1)if b.size.odd?
  s=a.size
  (a[0,s/2]..b[0,s/2]).each{
    n=(it*2).to_i
    r<<n if a.to_i<=n&&n<=b.to_i
  }
}
p r.sum
