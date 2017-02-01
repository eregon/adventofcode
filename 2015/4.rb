require 'digest/md5'

BASE = ARGF.read.chomp
ZEROS = "0"*6

p (1..Float::INFINITY).find { |n|
  Digest::MD5.hexdigest(BASE + n.to_s).start_with?(ZEROS)
}
