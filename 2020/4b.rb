def between?(a, b)
  -> s { n = s[/^\d+$/] and n.to_i.between?(a, b) }
end

FIELDS = {
  byr: between?(1920, 2002),
  iyr: between?(2010, 2020),
  eyr: between?(2020, 2030),
  hgt: -> s {
    /^(?<v>\d+)cm$/ =~ s && v.to_i.between?(150, 193) or
    /^(?<v>\d+)in$/ =~ s && v.to_i.between?(59, 76)
  },
  hcl: /^#\h{6}$/,
  ecl: /^(amb|blu|brn|gry|grn|hzl|oth)$/,
  pid: /^\d{9}$/,
}

p File.read('4.txt').split(/\n{2,}/).map { |lines|
  lines.split.to_h { |kv| kv.split(':', 2) }
}.count { |data|
  FIELDS.each_pair.all? { |name, predicate|
    value = data[name.to_s] and predicate === value
  }
}
