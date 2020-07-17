.PHONY: plugins
plugins:
	nvim +PlugInstall +qall
	nvim +UpdateRemotePlugins +qall
	nvim +"CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css" +qall
