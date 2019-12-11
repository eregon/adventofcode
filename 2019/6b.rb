lines = File.readlines('6.txt')

class Body
  attr_reader :name, :parent
  def initialize(name)
    @name = name
  end

  def parent=(parent)
    raise if @parent
    @parent = parent
  end
  
  def depth
    if @name == 'COM' and @parent.nil?
      0
    else
      @parent.depth + 1
    end
  end
end

bodies = Hash.new { |h,k| h[k] = Body.new(k) }

lines.each { |line|
  parent, child = line.chomp.split(')', 2)
  bodies[child].parent = bodies[parent]
}

a = bodies.fetch('YOU').parent
b = bodies.fetch('SAN').parent

steps = 0
while a != b
  da, db = a.depth, b.depth

  if da >= db
    a = a.parent
    steps += 1
  end

  if da <= db
    b = b.parent
    steps += 1
  end
end
p steps
