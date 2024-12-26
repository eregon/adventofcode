# Copied from 17b4.rb output
def run(n)
  a = n
  b, c = 0, 0
  ip = 0
  out = []
  -> {
    b = a % 8
    b ^= 1
    c = a / (2 ** b)
    b ^= 4
    b ^= c

    a /= 8

    out << b % 8
    return false unless out.last == Program[out.size-1]

    redo unless a == 0
  }.()
  out
end

Program = [2,4,1,1,7,5,1,4,0,3,4,5,5,5,3,0]

def iter(a)
  b = a % 8
  b ^= 1
  c = a / (2 ** b)
  b ^= 4
  b ^= c

  a /= 8

  b % 8
end

FOUND = []

def find(i, a)
  if i < 0
    FOUND << a
  else
    d = Program[i]
    (0...8).each { |n|
      v = n + (a << 3)
      if iter(v) == d
        find(i-1, v)
      end
    }
  end
end

find(Program.size - 1, 0)
p run(FOUND.min)
p FOUND.min
