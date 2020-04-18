all: clean SKK-JISYO.XL

SKK-JISYO.XL: 						\
	SKK-JISYO.S 						\
	SKK-JISYO.M 						\
	SKK-JISYO.ML 						\
	SKK-JISYO.L 						\
	SKK-JISYO.fullname 			\
	SKK-JISYO.geo 					\
	SKK-JISYO.jinmei 				\
	SKK-JISYO.law 					\
	SKK-JISYO.okinawa 			\
	SKK-JISYO.propernoun 		\
	SKK-JISYO.station	
	echo ';; -*- mode: fundamental; coding: euc-jp -*-' >SKK-JISYO.XL
	skkdic-expr2 $(shell sh -c 'ls SKK-JISYO.* | tr "\n" " " | sed "s! ! + !g" | sed "s!\+ \$$!!"') >>SKK-JISYO.XL

SKK-JISYO.%:
	curl -O https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.$*

clean:
	rm -rf SKK-JISYO.*

install: SKK-JISYO.XL
	test -d $(HOME)/.config/skk || mkdir -p $(HOME)/.config/skk
	cp SKK-JISYO.XL $(HOME)/.config/skk/
