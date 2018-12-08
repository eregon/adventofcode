require "set"

requirements = Hash.new { |h,k| h[k] = Set.new }
File.readlines("7.txt").map { |line|
  line =~ /Step (.+) must be finished before step (.+) can begin./
  requirements[$2] << $1
}

all_steps = requirements.map { |k,v| [k, v.to_a] }.flatten.uniq.sort

Worker = Struct.new(:task)
Task = Struct.new(:step, :end_time)

done = Set.new
remaining = all_steps.to_set
workers = Array.new(5) { Worker.new(nil) }
t = 0

loop do
  workers.each { |worker|
    if task = worker.task and task.end_time == t
      done << task.step
      worker.task = nil
    end
  }

  break if done.size == all_steps.size

  ready = remaining.select { |step|
    requirements[step].subset?(done)
  }

  workers.each { |worker|
    if !worker.task and step = ready.shift
      duration = 60 + (step.ord - "A".ord + 1)
      worker.task = Task.new(step, t + duration)
      remaining.delete(step)
    end
  }

  t += 1
end

p t
