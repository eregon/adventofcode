initial = '9,6,0,10,18,2,1'.split(',').map(&:to_i).freeze

last_seen_at = {}
p Enumerator.produce([initial.first, 0]) { |prev, i|
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
  [n, i+1]
}.take(2020).map(&:first).last
