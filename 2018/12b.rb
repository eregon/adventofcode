class String
  def pad
    raise if start_with?("....")
    until start_with?("...")
      prepend "."
      $offset -= 1
    end
    self << "." until end_with?("...")
    self
  end
end

$offset = 0
state, _, *rules = File.readlines("12.txt", chomp: true)
state = state[/initial state: (.+)/, 1].pad
rules = rules.map { |rule| rule.split(" => ") }.to_h
cache = {}

(1..50_000_000_000).each do |step|
  break if cache.key?(state) and cache[state][0] == state

  old_offset = $offset
  $offset += 2
  new_state = state.chars.each_cons(5).map { |s|
    rules[s.join] || "."
  }.join.pad

  cache[state] = [new_state, $offset-old_offset, step]
  state = new_state
end

repeating_state, doffset, step = cache[state]
$offset += (50_000_000_000 - step) * doffset
p state.each_char.with_index($offset).sum { |e,i| e == "." ? 0 : i }
