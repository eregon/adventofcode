p$<.sum{|l|l.scan(/(\d+) (\w+)/).all?{_1.to_i<%w[red green blue].index(_2)+13}?l[/\d+/].to_i: 0}