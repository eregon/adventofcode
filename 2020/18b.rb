using Module.new {
  refine(defined?(Fixnum) ? Fixnum : Integer) do
    alias_method :**, :+
  end
}

p File.readlines('18.txt', chomp: true).sum { |line|
  eval(line.gsub('+', '**'))
}
