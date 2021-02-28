require "json"

BENCHMARKS = File.readlines("benchmarks.txt").map(&:chomp)

PRETTY_NAMES = {
  '200' => '2.0.0',
  '300' => '3.0',
  '300jit' => '3.0+MJIT',
  'trdev' => 'TruffleRuby Native',
}

FORMAT_TIME = -> t { "%.3f" % t }
FORMAT_DELTA = -> t { "%+.3f" % t }

# FORMAT_TIME = -> t { "%d" % (t*1000).round }
# FORMAT_DELTA = -> t { "%+d" % (t*1000).round }

data = Dir["data/*.json"].sort.map { |file|
  basename = File.basename(file, ".*")
  name = PRETTY_NAMES[basename] || basename
  [name, JSON.load(File.read(file))]
}.select { |name, d| name }.to_h

data.delete('272')

IMPLS = data.keys
BASELINE = IMPLS.first

def stat(times)
  mean = times.sum / times.size.to_f

  # raise unless times.size % 2 == 0
  # median = times.sort[times.size/2, 2].sum / 2

  mean
end

table = []
column_names = IMPLS.zip(["Δ"] * IMPLS.size).flatten
column_names.delete_at(1)
table << ["Bench", *column_names]

def format_change(baseline, value)
  delta = value - baseline
  faster = baseline / value
  if faster >= 1.1
    "#{FORMAT_DELTA[delta]} #{"%.1f" % faster}x"
  else
    FORMAT_DELTA[delta]
  end
end

BENCHMARKS.each { |bench|
  bench_name = File.basename(bench, '.rb')
  table << row = [bench_name]
  IMPLS.each { |name|
    value = stat(data[name][bench])
    row << FORMAT_TIME[value]
    unless name == BASELINE
      baseline = stat(data[BASELINE][bench])
      row << format_change(baseline, value)
    end
  }
}

table << row = ["Total"]
IMPLS.each { |name|
  baseline = data[BASELINE].sum { |bench, times| stat(times) }
  total = data[name].sum { |bench, times| stat(times) }
  row << FORMAT_TIME[total]
  row << format_change(baseline, total) unless name == BASELINE
}

table.each { |row|
  $stderr.puts row.join("\t")
}

html = Object.new
def html.method_missing(name, options = {})
  r = yield
  r = r.join("\n") if Array === r
  options = options.empty? ? "" : " " + options.map { |k,v| "#{k}=#{v.inspect}" }.join(" ")
  "<#{name}#{options}>#{r}</#{name}>"
end

url_base = "https://github.com/eregon/adventofcode/blob/e894e2fd6b/2020"

t = table.dup
header = t.shift
last = t.pop

def highlight(s, options)
  if s[0] == '+' and Float(s.split[0]) > 0.5
    options[:class] = "slow"
  elsif s[0] == '-' and Float(s.split[0]) < -0.010
    options[:class] = "fast"
  end
  options
end

puts html.table {
  html.thead {
    header.map { |e| html.th { e } }
  } +
  html.tbody {
    t.map { |row|
      html.tr {
        name, *data = row
        [
          html.td {
            basename = "#{name}.rb"
            html.a(href: "#{url_base}/#{basename}") { "#{name}.rb" }
          },
          *data.map { |s|
            options = highlight(s, { style: "text-align: right" })
            html.td(options) { s }
          }
        ]
      }
    } + [
      html.tr {
        [
          html.td { html.strong { last.shift } },
          *last.map { |e|
            html.td(highlight(e, { style: "text-align: right" })) { html.strong { e } }
          }
        ]
      }
    ]
  }
}

__END__

puts header.join(" | ")
puts header.size.times.map { |i| "---#{':' unless i==0}" }.join(" | ")
t.each { |row|
  name, *data = row
  name = "[#{name}.rb](#{url_base}/#{name}.rb)"
  data = data.map { |s|
    if s[0] == '+' and s[1] != '0'
      "<span class=\"slow\">#{s}</span>"
    elsif s[0] == '-'
      "<span class=\"fast\">#{s}</span>"
    else
      s
    end
  }
  row = [name, *data]
  puts row.join(" | ")
}
puts last.map { |e| "__#{e}__" }.join(" | ")
