require 'digest/md5'

salt = "abc"
salt = "ahsbgdzn"

keys = []

(0..Float::INFINITY).each { |i|
  digest = Digest::MD5.hexdigest("#{salt}#{i}")
  if digest =~ /(.)\1\1/
    c = $1
    needle = (c * 5).freeze
    digest2 = (i+1..i+1000).find { |j|
      digest2 = Digest::MD5.hexdigest("#{salt}#{j}")
      digest2.include? needle
    }
    if digest2
      keys << [i, digest]
      p keys.size
      break if keys.size == 64
    end
  end
}

puts keys
