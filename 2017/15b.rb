starts = [591, 393]
factors = [16807, 48271]
multiples = [4, 8]

Generator = Struct.new(:start, :factor, :multiple) do
  def initialize(*)
    super
    @n = start
  end

  def next
    begin
      @n = (@n * factor) % 2147483647
    end until @n % multiple == 0
    @n
  end
end

generators = starts.zip(factors, multiples).map { |start, factor, multiple|
  Generator.new(start, factor, multiple)
}

p 5_000_000.times.count {
  a, b = generators.map { |gen| gen.next % 2**16 }
  a == b
}
