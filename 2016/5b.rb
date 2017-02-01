require 'digest/md5'

door_id = "reyedfim"
# door_id = "abc"

start = "00000"
code = " "*8

(0..Float::INFINITY).each { |i|
  md5 = Digest::MD5.hexdigest "#{door_id}#{i}"
  if md5.start_with?(start)
    p md5
    pos = Integer(md5[5], 16)
    digit = md5[6]
    if 0 <= pos and pos < 8
      if code[pos] == " "
        code[pos] = digit
      end
      break if code.count(" ") == 0
    end
  end
}
p code
