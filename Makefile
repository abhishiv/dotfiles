.PHONY: dependencies
dependencies:
	brew install neovim
	pip3 install neovim
	npm install -g neovim
	npm install -g spaceship-prompt
	pip3 install vim-vint
	npm i -g bash-language-server
	gem install colorls
	brew tap homebrew/cask-fonts
	brew cask install font-hack-nerd-font
	mkdir -p ~/.local/share/nvim/backup
	npm install -g vtop

.PHONY: link
link:
	bash install/backup.sh
	bash install/link.sh
	cp ~/.config/nvim/space.vim ~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/space.vim

.PHONY: nvim
nvim:
	nvim +PlugInstall +qall
	nvim +UpdateRemotePlugins +qall
	nvim +"CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css" +qall
