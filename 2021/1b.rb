data = File.readlines('1.txt').map { Integer(_1) }
p data.each_cons(3).map(&:sum).each_cons(2).count { _1 < _2 }
