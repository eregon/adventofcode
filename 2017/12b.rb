require 'set'

input = File.read("12.txt")
pipes = {}

input.strip.lines.each { |line|
  prog, pipe, *with = line.split.map(&:to_i)
  pipes[prog] = with
}

visited = Set.new

p pipes.keys.select { |start|
  unless visited.include?(start)
    stack = [start]
    while prog = stack.pop
      visited.add(prog)
      pipes[prog].each { |neighbor|
        stack.push(neighbor) unless visited.include? neighbor
      }
    end
    true
  end
}.size
