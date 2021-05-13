.PHONY: all console development \
	git zsh \
	npm cpm clipboard pt \
	mlterm _dunst _jwm _screenshot

all:
	@echo "usage: make <bundle|app>"

console: git zsh

development: npm cpm clipboard pt

_gui: dunst jwm screenshot

git:
	test -e ~/.gitconfig || ln -sf $(shell pwd)/git/gitconfig ~/.gitconfig
	test -e ~/.gitignore || ln -sf $(shell pwd)/git/gitignore ~/.gitignore

_tmux:
	test -e ~/.tmux.conf || ln -sf $(shell pwd)/tmux/tmux.conf ~/.tmux.conf

zsh:
	test -d ~/.config/zsh || mkdir -p ~/.config/zsh
	test -d ~/.config/zsh/enhancd				|| (cd ~/.config/zsh; git clone https://github.com/b4b4r07/enhancd)
	test -d ~/.config/zsh/powerlevel10k	|| (cd ~/.config/zsh; git clone https://github.com/romkatv/powerlevel10k)
	test -d ~/.zshrc 		|| ln -sf $(shell pwd)/zsh/zshrc.zsh 			~/.zshrc
	test -d ~/.zprofile || ln -sf $(shell pwd)/zsh/zprofile.zsh 	~/.zprofile
	test -d ~/.zshenv 	|| ln -sf $(shell pwd)/zsh/zshenv.zsh 		~/.zshenv
	test -d ~/.p10k.zsh || ln -sf $(shell pwd)/zsh/p10k.zsh 			~/.p10k.zsh

npm:
	npm config set prefix ~/.config/npm

cpm:
	test -d ~/.config/perl || mkdir -p ~/.config/perl
	(which cpanm && which cpm) || curl -L https://cpanmin.us/ | perl - -l "$$HOME/.config/perl" App::cpanminus App::cpm local::lib

clipboard:
	test -d ~/local/bin || mkdir -p ~/local/bin
	test -e ~/local/bin/clipboard	|| ln -sf $(shell pwd)/bin/clipboard ~/local/bin/clipboard

pt:
	test -d ~/local/bin || mkdir -p ~/local/bin
	cd /tmp && \
		( curl -L https://github.com/monochromegane/the_platinum_searcher/releases/download/v2.2.0/pt_linux_amd64.tar.gz \
			| tar -zxvf - pt_linux_amd64/pt ; \
				mv pt_linux_amd64/pt ~/local/bin/pt ; \
				rm -r /tmp/pt_linux_amd64 )

mlterm:
	test -d ~/.mlterm || mkdir -p ~/.mlterm
	test -e ~/.mlterm/color 	|| ln -sf $(shell pwd)/mlterm/color 	~/.mlterm/color
	test -e ~/.mlterm/key 		|| ln -sf $(shell pwd)/mlterm/key 		~/.mlterm/key
	( test "$(shell uname -s)" = "Linux" && ln -sf $(shell pwd)/mlterm/main.linux ~/.mlterm/main) || true 
	( test "$(shell uname -s)" = "Darwin" && ln -sf $(shell pwd)/mlterm/main.macOS ~/.mlterm/main) || true
	( [[ "$(shell uname -s)" =~ .*NT.* ]]  && ln -sf $(shell pwd)/mlterm/main.win32 ~/.mlterm/main) || true
	( test "$(shell uname -s)" = "Linux" && ln -sf $(shell pwd)/mlterm/font.linux ~/.mlterm/aafont) || true 
	( test "$(shell uname -s)" = "Darwin" && ln -sf $(shell pwd)/mlterm/font.macOS ~/.mlterm/aafont) || true
	( [[ "$(shell uname -s)" =~ .*NT.* ]]  && ln -sf $(shell pwd)/mlterm/font.win32 ~/.mlterm/font) || true

_dunst:
	test -d ~/.config/dunst || mkdir -p ~/.config/dunst
	test -e ~/.config/dunst/dunstrc || ln -sf $(shell pwd)/dunst/dunstrc ~/.config/dunst/dunstrc

_jwm:
	test -e ~/.jwmrc || ln -sf $(shell pwd)/jwm/jwmrc ~/.jwmrc

_screenshot:
	chmod +x $(shell pwd)/bin/screenshot.sh
	test -d ~/local/bin || mkdir -p ~/local/bin
	test -e ~/local/bin || ln -sf $(shell pwd)/bin/screenshot.sh ~/local/bin/screenshot.sh
