#!/bin/sh

# install vim

#info
cat <<EOF
EOF

# install

if [ ! -d ~/.vim/autoload ] || [ ! -f ~/.vim/autoload/plug.vim ]; then
	mkdir -p ~/.vim/autoload
	wget -O ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	cp $ROOT/vim/.vimrc ~/
fi
sudo apt-get install tmux vim
