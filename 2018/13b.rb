lines = File.readlines("13.txt", chomp: true)

DIRS = [1, 1.i, -1, -1.i]

CHOICE = [
  -> dir { DIRS[DIRS.index(dir)-1] }, # left
  -> dir { dir }, # straight
  -> dir { DIRS[DIRS.index(dir)-3] }, # right
]

Cart = Struct.new(:pos, :dir, :choice, :crashed) do
  def x
    pos.real
  end
  def y
    pos.imag
  end
end

carts = []

board = lines.map.with_index { |line, y|
  line.chars.map.with_index { |c, x|
    case c
    when "v", "^"
      dy = c == "v" ? 1.i : -1.i
      carts << Cart.new(x + y.i, dy, CHOICE.cycle, false)
      c = "|"
    when "<", ">"
      dx = c == ">" ? 1 : -1
      carts << Cart.new(x + y.i, dx, CHOICE.cycle, false)
      c = "-"
    end

    case c
    when "|"
      {-1.i => -1.i, 1.i => 1.i}
    when "-"
      {-1 => -1, 1 => 1}
    when "/"
      {-1.i => 1, -1 => 1.i, 1 => -1.i, 1.i => -1}
    when "\\"
      {-1.i => -1, 1 => 1.i, 1.i => 1, -1 => -1.i}
    when " "
      " "
    when "+"
      "+"
    else
      raise c
    end
  }
}

width = board.map(&:size).max

while carts.size > 1
  carts.sort_by! { |cart| cart.y * width + cart.x }

  carts.each { |cart|
    next if cart.crashed

    track = board[cart.y][cart.x]
    case track
    when Hash
      cart.dir = track.fetch(cart.dir)
      cart.pos += cart.dir
    when "+"
      cart.dir = cart.choice.next.call(cart.dir)
      cart.pos += cart.dir
    else
      raise track
    end

    if carts.map(&:pos).uniq.size != carts.size
      freq = Hash.new(0)
      carts.each { |cart| freq[cart.pos] += 1 }
      to_remove = []
      freq.each_pair { |pos, count| to_remove << pos if count > 1 }
      carts = carts.reject { |cart|
        if to_remove.include?(cart.pos)
          cart.crashed = true
        end
      }
    end
  }
end

cart = carts.first
puts "#{cart.x},#{cart.y}"
