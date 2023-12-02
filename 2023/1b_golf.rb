a=[*?0..?9,*%w[0 one two three four five six seven eight nine]].zip([*0..9]*2).to_h
d=[*a]*?|
p$<.sum{_1[/(#{d})(.*(#{d}))?/]&&a[$1]*10+a[$3||$1]}