p $<.map { it.split.map(&:to_i) }.transpose.map(&:sort).transpose.sum { (_1-_2).abs }