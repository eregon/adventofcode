p $<.sum { |l|
  series = l.split.map { Integer _1 }
  rows = [series]
  until series.all?(0)
    series = series.each_cons(2).map { _2 - _1 }
    rows << series
  end

  rows.last << 0
  rows.reverse_each.each_cons(2) { _2 << _2[-1] + _1[-1] }
  rows.first.last
}
