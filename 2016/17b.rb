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

input = "hijkl"
input = "ihgpwlah"
input = "kglvqrro"
input = "ulqzkmiv"
input = "qljzarfv"

def bfs(start, input)
  init = [start, input]
  q = [init]
  max_len = 0
  until q.empty?
    (x, y), path = q.shift # or q.pop
    if [x,y] == GOAL
      max_len = [max_len, path.size - input.size].max
      next # cannot continue from goal
    end
    md5 = Digest::MD5.hexdigest(path)
    DIRS.each_pair.with_index { |(d, (dx,dy)), i|
      if "b" <= md5[i] and md5[i] <= "f"
        tx, ty = x+dx, y+dy
        if tx.between?(0,N-1) and ty.between?(0,N-1)
          q << [[tx,ty], path + d]
        end
      end
    }
  end
  max_len
end

p bfs(START, input)
