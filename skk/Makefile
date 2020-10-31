all: clean SKK-JISYO.XL.utf8

SKK-JISYO.XL.utf8: SKK-JISYO.XL
	iconv -c -f EUC-JISX0213 -t utf8 < SKK-JISYO.XL >SKK-JISYO.XL.utf8
	sed -i 's|coding: euc-ji|coding: utf8|' SKK-JISYO.XL.utf8
	

SKK-JISYO.XL: 						\
	SKK-JISYO.S 						\
	SKK-JISYO.M 						\
	SKK-JISYO.ML 						\
	SKK-JISYO.L 						\
	SKK-JISYO.fullname 			\
	SKK-JISYO.geo 					\
	SKK-JISYO.law 					\
	SKK-JISYO.okinawa 			\
	SKK-JISYO.propernoun 		\
	SKK-JISYO.station 			\
	SKK-JISYO.neologd
	echo ';; -*- mode: fundamental; coding: euc-jp -*-' >SKK-JISYO.XL
	skkdic-expr2 $(shell sh -c 'ls SKK-JISYO.* | tr "\n" " " | sed "s! ! + !g" | sed "s!\+ \$$!!"') >>SKK-JISYO.XL

SKK-JISYO.%:
	curl -O https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.$*

SKK-JISYO.neologd:
	curl -LO https://raw.githubusercontent.com/tokuhirom/skk-jisyo-neologd/master/SKK-JISYO.neologd

SKK-JISYO.jawiki:
	curl -O https://raw.githubusercontent.com/tokuhirom/jawiki-kana-kanji-dict/master/SKK-JISYO.jawiki
	iconv -f utf-8 -t EUC-JISX0213//TRANSLIT < SKK-JISYO.jawiki >SKK-JISYO.jawiki.tmp
	rm SKK-JISYO.jawiki
	mv SKK-JISYO.jawiki.tmp SKK-JISYO.jawiki

clean:
	rm -rf SKK-JISYO.*

install: SKK-JISYO.XL
	test -d $(HOME)/.config/skk || mkdir -p $(HOME)/.config/skk
	cp SKK-JISYO.XL $(HOME)/.config/skk/
