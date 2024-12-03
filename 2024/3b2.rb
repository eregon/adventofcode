def mul(a,b)=a*b
enabled = true
sum = 0
$<.read.scan(/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/) {
  case it
  in "do()" then enabled = true
  in "don't()" then enabled = false
  else sum += eval(it) if enabled
  end
}
p sum