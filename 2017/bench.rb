require "benchmark"
require "json"

puts RUBY_DESCRIPTION
abort "Needs Ruby name" if ARGV.empty?

NAME = ARGV.shift
FLAGS = ARGV.join(' ')
BENCHMARKS = File.readlines("benchmarks.txt").map(&:chomp)
N = 10

data = BENCHMARKS.map { |bench|
  puts bench
  times = N.times.map {
    time = Benchmark.realtime {
      `ruby #{FLAGS} -r./compat #{bench}`
    }
    print "%.3f " % time
    time
  }
  puts
  [bench, times]
}.to_h

File.write "#{NAME}.json", JSON.dump(data)
