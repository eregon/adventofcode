dial = 50
p $<.map {
  dial = (dial + it.tr('LR', '-+').to_i) % 100
}.count(0)
