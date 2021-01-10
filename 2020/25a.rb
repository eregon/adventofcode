def subject_number(initial, loop_size)
  n = 1
  loop_size.times {
    n = (n * initial) % 20201227
  }
  n
end

def find_loop_size(initial, key)
  n = 1
  (1..).find {
    n = (n * initial) % 20201227
    n == key
  }
end

card_key = 1526110
door_key = 20175123

p card_loop = find_loop_size(7, card_key)
p door_loop = find_loop_size(7, door_key)

p subject_number(door_key, card_loop)
p subject_number(card_key, door_loop)
