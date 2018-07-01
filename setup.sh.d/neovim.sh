#!/bin/sh

# instal neo vim

# info 
cat <<EOF
EOF

# install
if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
	wget -O ~/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
sudo apt-get install neovim
