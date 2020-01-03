.PHONY: all git dunst mlterm tmux zsh vim lsp cpanm screenshot

all: git dunst mlterm tmux zsh vim

tools: lsp cpanm screenshot

git:
	ln -sf $(shell pwd)/git/gitconfig ~/.gitconfig
	ln -sf $(shell pwd)/git/gitignore ~/.gitignore

dunst:
	test -e ~/.config/dunst || mkdir -p ~/.config/dunst
	ln -sf $(shell pwd)/dunst/dunstrc ~/.config/dunst/dunstrc

mlterm:
	test -e ~/.mlterm || mkdir -p ~/.mlterm
	ln -sf $(shell pwd)/mlterm/aafont ~/.mlterm/aafont
	ln -sf $(shell pwd)/mlterm/color 	~/.mlterm/color
	ln -sf $(shell pwd)/mlterm/key 		~/.mlterm/key
	ln -sf $(shell pwd)/mlterm/main  	~/.mlterm/main
	test "$(shell uname -s)" != "Darwin" \
		|| \
			( ln -sf $(shell pwd)/mlterm/aafont.macOS ~/.mlterm/aafont; \
				ln -sf $(shell pwd)/mlterm/main  	~/.mlterm/main )

tmux:
	ln -sf $(shell pwd)/tmux/tmux.conf ~/.tmux.conf

zsh:
	test -d ~/.config/zsh/zfunctions 				|| mkdir -p ~/.config/zsh/zfunctions
	test -d ~/.config/zsh/enhancd || (cd ~/.config/zsh;git clone https://github.com/b4b4r07/enhancd)
	test -d ~/.config/zsh/pure 		|| (cd ~/.config/zsh; git clone https://github.com/sindresorhus/pure)
	ln -sf ~/.config/zsh/pure/async.zsh 	~/.config/zsh/zfunctions/async
	ln -sf ~/.config/zsh/pure/pure.zsh 		~/.config/zsh/zfunctions/prompt_pure_setup
	ln -sf $(shell pwd)/zsh/zshrc.zsh 		~/.zshrc
	ln -sf $(shell pwd)/zsh/zprofile.zsh 	~/.zprofile
	ln -sf $(shell pwd)/zsh/zshenv.zsh 		~/.zshenv

vim:
	test -r ~/.config/volt || ln -sf ~/local/dotfiles/vim ~/.config/volt
	test -d ~/.cache/vim || zsh -c "mkdir -p ~/.cache/vim/{swap,backup}"

lsp:
	test -d ~/.config/npm || mkdir -p ~/.config/npm
	npm config set prefix "$$HOME"/.config/npm
	npm install -g \
      bash-language-server        \
      dockerfile-language-service  \
      typescript-eslint-language-service  \
      vscode-css-languageservice   \
      vscode-json-languageservice

cpanm:
	test -d ~/.config/perl5 || mkdir -p ~/.config/perl5
	curl -L http://cpanmin.us | perl - -l "$$HOME"/.config/perl5 App::cpanminus
	cpanm -l "$$HOME"/.config/perl5 local::lib 

clipboard:
	chmod +x $(shell pwd)/scripts/clipboard
	test -d ~/local/bin || mkdir -p ~/local/bin
	ln -sf $(shell pwd)/scripts/clipboard ~/local/bin/clipboard

screenshot:
	chmod +x $(shell pwd)/scripts/screenshot.sh
	test -d ~/local/bin || mkdir -p ~/local/bin
	ln -sf $(shell pwd)/scripts/clipboard ~/local/bin/screenshot
