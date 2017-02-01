require 'digest/md5'

door_id = "reyedfim"
# door_id = "abc"

start = "00000"
n = 8
code = ""

(0..Float::INFINITY).each { |i|
  md5 = Digest::MD5.hexdigest "#{door_id}#{i}"
  if md5.start_with?(start)
    p md5
    digit = md5[start.size]
    code << digit.to_s
    if code.size == n
      break
    end
  end
}
p code
