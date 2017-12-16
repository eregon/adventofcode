starts = [591, 393]
factors = [16807, 48271]

Generator = Struct.new(:start, :factor) do
  def initialize(*)
    super
    @n = start
  end

  def next
    @n = (@n * factor) % 2147483647
  end
end

generators = starts.zip(factors).map { |start, factor|
  Generator.new(start, factor)
}

p 40_000_000.times.count {
  a, b = generators.map { |gen| gen.next % 2**16 }
  a == b
}
