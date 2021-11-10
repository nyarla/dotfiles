FLATERY_URL = https://github.com/cbrnix/Flatery
PT_URL = https://github.com/monochromegane/the_platinum_searcher/releases/download/v2.2.0/pt_linux_amd64.tar.gz
VICTORY_URL = https://gitlab.com/newhoa/victory-gtk-theme

all:
	@echo "usage: make <bundle|app>"

.PHONY: git zsh starship nvim
console: git zsh starship nvim

git:
	test -e ~/.gitconfig || ln -sf $(shell pwd)/git/gitconfig ~/.gitconfig
	test -e ~/.gitignore || ln -sf $(shell pwd)/git/gitignore ~/.gitignore

zsh:
	test -d ~/.config/zsh || mkdir -p ~/.config/zsh
	test -d ~/.config/zsh/z || (cd ~/.config/zsh; git clone https://github.com/rupa/z)
	test -e ~/.zprofile || ln -sf $(shell pwd)/zsh/zprofile.zsh ~/.zprofile
	test -e ~/.zshenv || ln -sf $(shell pwd)/zsh/zshenv.zsh ~/.zshenv
	test -e ~/.zshrc || ln -sf $(shell pwd)/zsh/zshrc.zsh ~/.zshrc

starship:
	test -e ~/.config || mkdir -p ~/.config
	test -e ~/.config/starship.toml || ln -sf $(shell pwd)/starship/starship.toml ~/.config/starship.toml

nvim:
	test -e ~/local/dotnvim || (cd ~/local ; git clone https://github.com/nyarla/dotnvim)
	test -d ~/.config || mkdir -p ~/.config
	test -e ~/.config/nvim || ln -sf ~/local/dotnvim ~/.config/nvim


.PHONY: clipboard pt restic
commands: clipboard pt restic

clipboard:
	test -d ~/local/bin || mkdir -p ~/local/bin
	test -e ~/local/bin/clipboard || ln -sf $(shell pwd)/bin/clipboard ~/local/bin/

pt:
	test -d ~/local/bin || mkdir -p ~/local/bin
	test -e ~/local/bin/pt || (\
		cd /tmp; \
		curl -L $(PT_URL) | tar -zxvf - pt_linux_amd64/pt; \
		mv pt_linux_amd64/pt ~/local/bin/pt; \
		rm -rf /tmp/pt_linux_amd )

restic:
	test -d ~/local/bin || mkdir -p ~/local/bin
	test -e ~/local/bin/restic || ln -sf $(shell pwd)/bin/restic ~/local/bin/
	test -e ~/local/bin/restic-backup || ln -sf $(shell pwd)/bin/restic-backup ~/local/bin/

.PHONY: npm
dev: npm

npm:
	npm config -g set prefix ~/.local/share/npm

.PHONY: mlterm
terminal: mlterm

mlterm:
	test -d ~/.mlterm || mkdir -p ~/.mlterm
	test -e ~/.mlterm/color || ln -sf $(shell pwd)/mlterm/color ~/.mlterm/color
	test -e ~/.mlterm/key || ln -sf $(shell pwd)/mlterm/key ~/.mlterm/key
	test -e ~/.mlterm/main || (\
		(test "$(shell uname -s)" = "Linux" && ln -sf $(shell pwd)/mlterm/main.linux ~/.mlterm/main && exit) || true ;\
		(test "$(shell uname -s)" = "Darwin" && ln -sf $(shell pwd)/mlterm/main.macOS ~/.mlterm/main && exit) || true ;\
		([[ "$(shell uname -s)" =~ .*NT.* ]] && ln -sf $(shell pwd)/mlterm/main.linux ~/.mlterm/main && exit) || true );
	test -e ~/.mlterm/font || (\
		(test "$(shell uname -s)" = "Linux" && ln -sf $(shell pwd)/mlterm/font.linux ~/.mlterm/font && exit) || true ;\
		(test "$(shell uname -s)" = "Darwin" && ln -sf $(shell pwd)/mlterm/font.macOS ~/.mlterm/font && exit) || true ;\
		([[ "$(shell uname -s)" =~ .*NT.* ]] && ln -sf $(shell pwd)/mlterm/font.linux ~/.mlterm/font && exit) || true );

.PHONY: icons themes openbox
desktop: icons themes openbox

icons:
	test -e ~/.local/share/icons || mkdir -p ~/.local/share/icons
	test -d ~/.local/share/icons/.git || (\
		git init; \
		git remote add upstream $(FLATERY_URL); \
		git pull upstream master )

themes:
	test -e ~/.local/share/themes || mkdir -p ~/.local/share/themes
	test -d ~/.local/share/icons/.git || (\
		git init; \
		git remote add upstream $(VICTORY_URL); \
		git pull upstream master )

openbox:
	test -e ~/.config || mkdir -p ~/.config
	test -d ~/.config/openbox || ln -sf $(shell pwd)/openbox ~/.config/openbox 

.PHONY: kindle
wine: kindle

kindle:
	test -d ~/local/bin || mkdir -p ~/local/bin
	test -e ~/local/bin/kindle || ln -sf $(shell pwd)/launch/kindle ~/local/bin/
