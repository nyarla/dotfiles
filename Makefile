all: console toolchain gui

wsl2: console toolchain mlterm


.PHONY: git tmux zsh nvim
console: git tmux zsh nvim

git:
	test -e ~/.gitconfig || ln -sf $(shell pwd)/git/gitconfig
	test -e ~/.gitignore || ln -sf $(shell pwd)/git/gitignore

tmux:
	test -e ~/.tmux.conf || ln -sf $(shell pwd)/.tmux.conf

zsh:
	test -d ~/.config/zsh/zfunctions || mkdir -p ~/.config/zsh/zfunctions
	test -d ~/.config/zsh/enhancd    || (cd ~/.config/zsh; git clone https://github.com/b4b4r07/enhancd)
	test -d ~/.config/zsh/pure 		   || (cd ~/.config/zsh; git clone https://github.com/sindresorhus/pure)
	test -e ~/.config/zsh/zfunctions/async.zsh \
		|| ln -sf ~/.config/zsh/pure/async.zsh 	~/.config/zsh/zfunctions/async
	test -e ~/.confit/zsh/zfunctions/prompt_pure_setup \
		|| ln -sf ~/.config/zsh/pure/pure.zsh 	~/.config/zsh/zfunctions/prompt_pure_setup
	test -d ~/.zshrc 		|| ln -sf $(shell pwd)/zsh/zshrc.zsh 			~/.zshrc
	test -d ~/.zprofile || ln -sf $(shell pwd)/zsh/zprofile.zsh 	~/.zprofile
	test -d ~/.zshenv 	|| ln -sf $(shell pwd)/zsh/zshenv.zsh 		~/.zshenv

nvim:
	test -d ~/.cache/nvim 	|| mkdir -p ~/.cache/nvim/{swap,backup}
	test -d ~/.config/nvim 	|| (cd ~/.config; git clone https://github.com/nyarla/dotnvim nvim)

.PHONY: npm cpm clipboard pt
toolchain: npm cpm clipboard pt

npm:
	npm config -g set prefix ~/.config/npm

cpm:
	test -d ~/.config/perl || mkdir -p ~/.config/perl
	(which cpanm && which cpm) || curl -L https://cpanmin.us/ | perl - -l "$$HOME/.config/perl" App::cpanminus App::cpm local::lib

clipboard:
	test -d ~/local/bin || mkdir -p ~/local/bin
	test -e ~/local/bin/clipboard	|| ln -sf $(shell pwd)/scripts/clipboard ~/local/bin/clipboard

pt:
	test -d ~/dev || mkdir -p ~/dev
	which pt \
		|| (env GOPATH=$$HOME/dev go get -u github.com/monochromegane/the_platinum_searcher; \
				cd ~/dev/src/github.com/monochromegane/the_platinum_searcher/cmd/pt; \
				env GOPATH=$$HOME/dev go build .; \
				cp pt ~/local/bin/pt )

.PHONY: dunst jwm mlterm screenshot
gui: dunst jwm mlterm screenshot

dunst:
	test -d ~/.config/dunst || mkdir -p ~/.config/dunst
	test -e ~/.config/dunst/dunstrc || ln -sf $(shell pwd)/dunst/dunstrc ~/.config/dunst/dunstrc

jwm:
	test -e ~/.jwmrc || ln -sf $(shell pwd)/jwm/jwmrc ~/.jwmrc

mlterm:
	test -d ~/.mlterm || mkdir -p ~/.mlterm
	test -e ~/.mlterm/aafont 	|| ln -sf $(shell pwd)/mlterm/aafont ~/.mlterm/aafont
	test -e ~/.mlterm/color 	|| ln -sf $(shell pwd)/mlterm/color 	~/.mlterm/color
	test -e ~/.mlterm/key 		|| ln -sf $(shell pwd)/mlterm/key 		~/.mlterm/key
	test -e ~/.mlterm 				|| ln -sf $(shell pwd)/mlterm/main  	~/.mlterm/main
	test "$(shell uname -s)" != "Darwin" \
		|| \
			( rm ~/.mlterm/aafont	; ln -sf $(shell pwd)/mlterm/aafont.macOS ~/.mlterm/aafont; \
				rm ~/.mlterm/main 	; ln -sf $(shell pwd)/mlterm/main  	~/.mlterm/main )

screenshot:
	chmod +x $(shell pwd)/scripts/screenshot.sh
	test -d ~/local/bin || mkdir -p ~/local/bin
	test -e ~/local/bin || ln -sf $(shell pwd)/scripts/clipboard ~/local/bin/screenshot
