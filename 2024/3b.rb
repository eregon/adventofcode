def mul(a,b)=a*b
# Both work:
# pp"do()#{$<.read}".scan(/(?:do\(\)|don't\(\)).*?(?=\Z|do\(\)|don't\(\))/m)
# pp"do()#{$<.read}".scan(/(?:do\(\)|don't\(\))(?:(?!do\(\)|don't\(\)).)*/m)
pp"do()#{$<.read}".scan(/(?:do\(\)|don't\(\)).*?(?=\Z|do\(\)|don't\(\))/m).grep(/\Ado\(\)/).sum{
  it.scan(/mul\(\d{1,3},\d{1,3}\)/).sum{eval it}
}