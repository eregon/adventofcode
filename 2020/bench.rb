require "benchmark"
require "json"
require "fileutils"

require 'backports/2.6.0/array/to_h' if RUBY_VERSION == '2.0.0'

puts RUBY_DESCRIPTION
abort "Needs Ruby name" if ARGV.empty?

NAME = ARGV.shift
FLAGS = ARGV.join(' ')
BENCHMARKS = File.readlines("benchmarks.txt").map(&:chomp)
N = Integer(ENV['N'] || 10)

RUBY2 = RUBY_VERSION.start_with?('2.0')
FLAGS << ' -r./backport.rb' if RUBY2

RESULTS_DIR = "results/#{NAME}"
FileUtils.mkdir_p(RESULTS_DIR)

data = BENCHMARKS.map { |bench|
  puts bench

  file = bench
  file = ".rbnext/#{file}" if RUBY2 && File.exist?(".rbnext/#{file}")

  result_file = "#{RESULTS_DIR}/#{File.basename(bench, '.rb')}.txt"

  out = nil
  times = N.times.map {
    time = Benchmark.realtime {
      out = `ruby #{FLAGS} #{file}`
      abort unless $?.success?
    }
    print "%.3f " % time
    time
  }
  puts
  File.write(result_file, out)

  [bench, times]
}.to_h

File.write "#{NAME}.json", JSON.dump(data)
