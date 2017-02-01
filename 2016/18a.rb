n = 4
input = "..^^."

n = 10
input = ".^^.^.^^^^"

n = 40
input = "...^^^^^..^...^...^^^^^^...^.^^^.^.^.^^.^^^.....^.^^^...^^^^^^.....^.^^...^^^^^...^.^^^.^^......^^^^"

# n = 400_000

board = [input.chars.map { |e| e != "." }]
until board.size == n
  board << [false,*board.last,false].each_cons(3).map { |a,b,c| a != c }
end

board.each { |row|
  puts row.map { |e| e ? "^" : "." }.join
} if n < 100

p board.reduce(0) { |sum,row| sum + row.count(false) }


# (a && b && !c) ||
# (!a && b && c) ||
# (a && !b && !c) ||
# (!a && !b && c)
