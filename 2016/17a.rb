require 'digest/md5'

N = 4
START = [0,0]
GOAL = [N-1,N-1]
DIRS = {
  'U' => [0, -1],
  'D' => [0, 1],
  'L' => [-1, 0],
  'R' => [1, 0],
}

INPUT = "hijkl"
INPUT = "ihgpwlah"
INPUT = "kglvqrro"
INPUT = "ulqzkmiv"
INPUT = "qljzarfv"

def md5(str)
  Digest::MD5.hexdigest(str)
end

def bfs()
  init = [START, INPUT]
  q = [init]
  prev = {}
  until q.empty?
    (x, y), path = q.shift
    if [x,y] == GOAL
      return path[INPUT.size..-1]
    end
    md5 = md5(path)
    DIRS.each_pair.with_index { |(d, (dx,dy)), i|
      if "b" <= md5[i] and md5[i] <= "f"
        tx, ty = x+dx, y+dy
        if tx.between?(0,N-1) and ty.between?(0,N-1)
          p [[x,y], [tx,ty], path+d]
          q << [[tx,ty], path + d]
        end
      end
    }
  end
  [:impossible]
end

p bfs()
