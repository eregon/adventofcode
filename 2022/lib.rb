def Integer.to_proc
  -> v { Integer(v) }
end
Int = Integer

class Array
  def single
    raise inspect unless size == 1
    first
  end
end
