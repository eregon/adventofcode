require 'digest/md5'

salt = "abc"
salt = "ahsbgdzn"

keys = []

hashes = Hash.new { |h,k|
  digest = Digest::MD5.hexdigest("#{salt}#{k}")
  2016.times {
    digest = Digest::MD5.hexdigest(digest)
  }
  h[k] = digest
}

(0..Float::INFINITY).each { |i|
  digest = hashes[i]
  if digest =~ /(.)\1\1/
    c = $1
    needle = (c * 5).freeze
    digest2 = (i+1..i+1000).find { |j|
      hashes[j].include? needle
    }
    if digest2
      p i
      keys << [i, digest]
      p keys.size
      break if keys.size == 64
    end
  end
}

puts keys
