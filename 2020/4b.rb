def between?(a, b)
  -> s { Integer(s, exception: false)&.between?(a, b) }
end

FIELDS = {
  byr: between?(1920, 2002),
  iyr: between?(2010, 2020),
  eyr: between?(2020, 2030),
  hgt: -> s {
    /^(?<v>\d+)(?<unit>cm|in)$/ =~ s and
    (unit == 'cm' ? between?(150, 193) : between?(59, 76)) === v
  },
  hcl: /^#\h{6}$/,
  ecl: %w[amb blu brn gry grn hzl oth].method(:include?),
  pid: /^\d{9}$/,
}

p File.read('4.txt').split(/\n{2,}/).map { |lines|
  lines.split.to_h { |kv| kv.split(':', 2) }
}.count { |data|
  FIELDS.each_pair.all? { |name, predicate|
    value = data[name.to_s] and predicate === value
  }
}
