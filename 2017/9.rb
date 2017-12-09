input = File.read("9.txt").strip

def run(stream)
  score = 0
  payload = 0

  # Returns the index of the next character to parse
  parse = -> from, depth {
    case stream[i = from]
    when '{'
      if stream[i+1] == '}'
        i += 2
      else
        begin
          i = parse[i+1, depth+1]
        end while stream[i] == ','
        raise unless stream[i] == '}'
        i += 1
      end
      score += depth
    when '<'
      loop {
        case stream[i += 1]
        when '!'
          i += 1
        when '>'
          break i += 1
        else
          payload += 1
        end
      }
    else
      raise stream[from]
    end
    i
  }

  parse[0, 1]
  [score, payload]
end

p run(input)
