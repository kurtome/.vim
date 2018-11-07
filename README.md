A complete .vim directory. This is mostly for me to keep my vim settings in sync across machines, but feel free to use it.

Usage
-----
To use just have Vim version  7 or higher and replace you ~/.vim directory with this. BE CAREFUL NOT TO BLOW AWAY YOUR .vim FOLDER UNLESS YOU REALLY WANT TO.

	git clone git@github.com:kurtome/.vim.git ~/.vim


Replace your entire .vimrc contents with this line (or add customizations AFTER
this line)

	source ~/.vim/vimrc

Install Vundle into `.vim/bundle`

	$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Tell Vundle to run and install all configured plugins

	vim +PluginInstall +qall
