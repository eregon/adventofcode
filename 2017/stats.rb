require "json"

BENCHMARKS = File.readlines("benchmarks.txt").map(&:chomp)

PRETTY_NAMES = {
  'mri-trunk' => 'MRI trunk',
  'yarv-mjit' => 'YARV-MJIT',
  'rtl-mjit' => 'RTL-MJIT',
  'graalvm0.31-native' => 'TruffleRuby Native',
}
IMPLS = PRETTY_NAMES.values

FORMAT_TIME = -> t { "%.3f" % t }
FORMAT_DELTA = -> t { "%+.3f" % t }

# FORMAT_TIME = -> t { "%d" % (t*1000).round }
# FORMAT_DELTA = -> t { "%+d" % (t*1000).round }

BASELINE = 'MRI trunk'

data = Dir["data/*.json"].map { |file|
  name = PRETTY_NAMES[File.basename(file, ".*")]
  [name, JSON.load(File.read(file))]
}.select { |name, d| name }.to_h

def stat(times)
  mean = times.sum / times.size.to_f

  # raise unless times.size % 2 == 0
  # median = times.sort[times.size/2, 2].sum / 2

  mean
end

table = []
column_names = IMPLS.zip(["Δ"] * PRETTY_NAMES.size).flatten
column_names.delete_at(1)
table << ["Bench", *column_names]

BENCHMARKS.each { |bench|
  bench_name = bench == "17b_no_buffer.rb" ? "17b" : File.basename(bench, '.rb')
  table << row = [bench_name]
  IMPLS.each { |name|
    value = stat(data[name][bench])
    row << FORMAT_TIME[value]
    if name != BASELINE
      row << FORMAT_DELTA[value - stat(data[BASELINE][bench])]
    end
  }
}

table << row = ["Total"]
IMPLS.each { |name|
  baseline = data[BASELINE].sum { |bench, times| stat(times) }
  total = data[name].sum { |bench, times| stat(times) }
  row << FORMAT_TIME[total]
  row << FORMAT_DELTA[total-baseline] unless name == BASELINE
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

url_base = "https://github.com/eregon/adventofcode/blob/a483e444/2017"

t = table.dup
header = t.shift
last = t.pop

def highlight(s, options)
  if s[0] == '+' and s[1] != '0'
    options[:class] = "slow"
  elsif s[0] == '-'
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
            basename = name == "17b" ? "17b_no_buffer.rb" : "#{name}.rb"
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
