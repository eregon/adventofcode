require 'json'

json = STDIN.read
data = JSON.parse(json)

NUMBERS = []

def collect(data)
  case data
  when Integer then NUMBERS << data
  when String then # ignore
  when Array then data.each { |e| collect(e) }
  when Hash
    data.each_pair { |k,v|
      collect(k)
      collect(v)
    }
  else raise data.inspect
  end
end

collect(data)

p NUMBERS.reduce(0, :+)
