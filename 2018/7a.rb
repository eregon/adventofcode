require "set"

requirements = Hash.new { |h,k| h[k] = Set.new }
File.readlines("7.txt").map { |line|
  line =~ /Step (.+) must be finished before step (.+) can begin./
  requirements[$2] << $1
}

all_steps = requirements.map { |k,v| [k, v.to_a] }.flatten.uniq.sort

done = Set.new
remaining = all_steps.to_set

until remaining.empty?
  step = remaining.find { |step|
    requirements[step].subset?(done)
  }
  remaining.delete(step)
  done << step
end

puts done.to_a.join
