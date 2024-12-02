p File.readlines(*$*).map { it.split.map(&:to_i) }.count { |levels|
  (levels.size+1).times.any? { |i|
    l = levels.dup.tap { it.delete_at(i) }
    l.each_cons(2).all? { _2.between?(_1+1, _1+3) } ||
    l.each_cons(2).all? { _1.between?(_2+1, _2+3) }
  }
}