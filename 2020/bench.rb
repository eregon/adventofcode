require "benchmark"
require "json"

puts RUBY_DESCRIPTION
abort "Needs Ruby name" if ARGV.empty?

NAME = ARGV.shift
FLAGS = ARGV.join(' ')
BENCHMARKS = File.readlines("benchmarks.txt").map(&:chomp)
N = Integer(ENV['N'] || 10)

RUBY2 = RUBY_VERSION.start_with?('2.0')
FLAGS << ' -r./backport' if RUBY2

data = BENCHMARKS.map { |bench|
  puts bench
  times = N.times.map {
    time = Benchmark.realtime {
      `ruby #{FLAGS} #{bench}`
      abort unless $?.success?
    }
    print "%.3f " % time
    time
  }
  puts
  [bench, times]
}.to_h

File.write "#{NAME}.json", JSON.dump(data)
