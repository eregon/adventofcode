p $<.sum { |l|
  series = l.split.map { Integer _1 }
  rows = [series]
  until series.all?(0)
    series = series.each_cons(2).map { _2 - _1 }
    rows << series
  end

  rows.last.unshift 0
  rows.reverse_each.each_cons(2) { _2.unshift(_2[0] - _1[0]) }
  rows.first.first
}
