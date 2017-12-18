input = File.read("18.txt")

class Program
  REG = /[a-z]/
  OP = /(?:#{REG}|-?\d+)/

  attr_writer :other
  attr_reader :queue

  def initialize(input, pid)
    @pid = pid
    @registers = Hash.new(0)
    @registers['p'] = pid
    @queue = Queue.new
    @sends = 0
    parse(input)
  end

  def val(str)
    if REG =~ str
      r = str
      -> { @registers[r] }
    else
      v = Integer(str)
      -> { v }
    end
  end

  def parse(input)
    @code = input.strip.lines.map { |line|
      case line
      when /^set (#{REG}) (#{OP})$/
        r, v = $1, val($2)
        -> { @registers[r] = v.call }
      when /^add (#{REG}) (#{OP})$/
        r, v = $1, val($2)
        -> { @registers[r] += v.call }
      when /^mul (#{REG}) (#{OP})$/
        r, v = $1, val($2)
        -> { @registers[r] *= v.call }
      when /^mod (#{REG}) (#{OP})$/
        r, v = $1, val($2)
        -> { @registers[r] %= v.call }
      when /^snd (#{OP})$/
        v = val($1)
        -> {
          @sends += 1
          @other.queue << v.call
        }
      when /^rcv (#{REG})$/
        r = $1
        -> {
          ok = false
          begin
            @registers[r] = @queue.pop
            ok = true
          ensure
            puts "Program #{@pid} sent #{@sends} messages\n" unless ok
          end
        }
      when /^jgz (#{OP}) (#{OP})$/
        v, off = val($1), val($2)
        -> pc { pc + (v.call > 0 ? off.call : 1) }
      else
        raise line
      end
    }
  end

  def run
    loop {
      pc = 0
      while instr = @code[pc]
        if instr.arity == 0
          instr.call
          pc += 1
        else
          pc = instr.call(pc)
        end
      end
    }
  end
end

a = Program.new(input, 0)
b = Program.new(input, 1)
a.other, b.other = b, a
[a, b].map { |prog| Thread.new { prog.run } }.each(&:join)
