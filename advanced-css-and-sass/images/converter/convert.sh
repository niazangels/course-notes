# mogrify -format jpg *.png
# mogrify -set filename:name '%t_q%Q' -quality 30 -write '%[filename:name].jpg' *.jpg
mogrify -quality 30 *.jpg
