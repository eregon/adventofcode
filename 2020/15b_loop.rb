initial = '9,6,0,10,18,2,1'.split(',').map(&:to_i).freeze

last_seen_at = {}
i = 0
n = initial.first
while i < 30_000_000
  prev = n
  n = if i < initial.size-1
    initial[i+1]
  else
    if prev_idx = last_seen_at[prev]
      i - prev_idx
    else
      0
    end
  end

  last_seen_at[prev] = i
  i += 1
end
p prev
