require 'time'

data = File.readlines("4.txt", chomp: true).map { |line|
  /^\[(?<time>.+)\] (?<action>.+)$/ =~ line
  time = Time.parse(time)
  date = time.to_date
  date = date.next_day if time.hour >= 12
  [date, time, action]
}.group_by { |date,| date }.values.map { |events|
  events.sort_by { |date, time,|
    time
  }.map { |date, time, action|
    [time, action]
  }
}.map { |events|
  (t0, start), *events = events
  /Guard #(\d+) begins shift/ =~ start or raise
  guard = $1.to_i
  naps = events.each_slice(2).map { |(t1, asleep), (t2, wake)|
    raise unless asleep.include? "falls asleep"
    raise unless wake.include? "wakes up"
    (t1.min...t2.min)
  }
  [guard, naps]
}.group_by { |guard,| guard }.transform_values { |naps|
  naps.map(&:last)
}

most_asleep = data.transform_values { |nights|
  nights.sum { |night| night.sum { |nap| nap.end - nap.begin } }
}.max_by { |guard, sleep_time| sleep_time }.first

asleep = Hash.new(0)
data[most_asleep].each { |night|
  night.each { |nap|
    nap.each { |min|
      asleep[min] += 1
    }
  }
}

p most_asleep * asleep.max_by(&:last).first
