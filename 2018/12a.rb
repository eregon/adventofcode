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

(1..20).each do |step|
  $offset += 2
  state = state.chars.each_cons(5).map { |s|
    rules[s.join] || "."
  }.join.pad
  puts ("%2d: " % step) + state
end

p state.each_char.with_index($offset).sum { |e,i| e == "." ? 0 : i }
