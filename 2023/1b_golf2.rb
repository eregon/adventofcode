a=[*?0..?9]+%w[0 one two three four five six seven eight nine]
p$<.sum{_1[/(#{a*?|})(.*(#{a*?|}))?/]&&a.index($1)%10*10+a.index($3||$1)%10}