require_relative 'lib'

lines = File.readlines('7.txt', chomp: true)

fs = Hash.new { |h,k| h[k] = Hash.new(&h.default_proc) }
stack = []
define_method :cwd do
  stack.last
end

stream = ArrayIterator.new(lines)
while line = stream.next
  raise line unless line.start_with?('$ ')
  command, *args = line[2..].split(' ', 2)
  case command
  in 'cd'
    case args.single
    in '/'
      stack = [fs]
    in '..'
      stack.pop
    in to
      stack << cwd[to]
    end
  in 'ls'
    raise unless args.empty?
    while stream.peek and !stream.peek.start_with?('$ ')
      line = stream.next
      case line
      in /^dir (.+)$/
        cwd[$1]
      in /^(\d+) (.+)$/
        cwd[$2] = Integer($1)
      end
    end
  end
end

# pp fs

def compute_size(dir, &block)
  return dir if Int === dir
  size = dir.each_pair.sum { |name, value|
    compute_size(value, &block)
  }
  yield size
  size
end

total = 70000000
goal = 30000000
used = compute_size(fs) {}
left = total - used
need = goal - left

p to_enum(:compute_size, fs).select { |size|
  size >= need
}.min
