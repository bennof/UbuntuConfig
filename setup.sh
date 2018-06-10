#!/bin/sh

echo "Ubuntu Config Script"
echo "written by Benjamin Falkner"

#check for os
VERSION=$(uname -v)
if [ "$VERSION" = *"Ubuntu"* ]; then
	OS="Ubuntu"
else 
	OS="Debian"
fi

#set dirs
ROOT=$(pwd)
cd ~

#summary
cat <<EOF
Summary:
Linux distro: ....... $OS
Home directory: ..... $(pwd)
Source directory: ... $ROOT
Script: ............. $0
EOF

#function block
update () { ## update system
	sudo apt-get update
	sudo apt-get upgrade
}

clean () { ## clean up system
	sudo apt-get -f install
	sudo apt-get --purge autoremove
}


#editors
vim () { ## install vim vi improved
	if [ ! -f ~/.vim/autoload/plug.vim ]; then
		wget -O ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
	cp $ROOT/vim/.vimrc ~/
	sudo apt-get install vim
}

neovim () { ## install neovim
	if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
		wget -O ~/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
	sudo apt-get install neovim
}

emacs () { ## install emacs with spacemacs
	git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
	sudo apt-get install emacs
}

vscode () { ## install Microsoft Visual Studio Code
	if [ ! -f /etc/apt/trusted.gpg.d/microsoft.gpg ]; then 
		sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
		wget  https://packages.microsoft.com/keys/microsoft.asc 
		gpg --dearmor microsoft.asc
		sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
		rm microsoft.asc microsoft.asc.gpg
		sudo apt-get update
	fi
	sudo apt-get install code
}

#programming 
git () { ## install git
	sudo apt-get install git
}
clike () { ## install c and make
	sudo apt-get install gcc make
}
r () { ## install r
	sudo apt-get install r-base
}
js () { ## install javascript, nodejs and npm
	sudo apt-get install nodejs npm
}
python () { ## install python and pip (version 3)
	sudo apt-get install python3 python3-pip
}
clojure () { ## install clojure, jdk and lein
	sudo apt-get install openjdk-11-jdk
	wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O ~/bin/lein
	chmod u+x ~/bin/lein
}
erlang () { ## install erlang and elixir
	if [ ! -f /etc/apt/sources.list.d/erlang-solutions.list ]; then
		wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
		sudo dpkg -i erlang-solutions_1.0_all.deb
		sudo apt-get update
		rm erlang-solutions_1.0_all.deb
	fi
	sudo apt-get install esl-erlang elixir
}

dev () { ## install development tools [meta package]
	git; clike; r; js; python; clojure; erlang
}
#plan9
plan9 () { ## install plan 9 tools
	sudo apt-get install xorg-dev
	if [ ! -d ~/plan9port ]; then 
		git clone https://github.com/9fans/plan9port ~/plan9port
		cd ~/plan9port
		./INSTALL 
		cd ..
		echo 'PLAN9=/home/benno/plan9port export PLAN9' >> .profile
		echo 'PATH=$PATH:$PLAN9/bin export PATH' >> .profile
		mkdir -p ~/bin
		cp $ROOT/bin/* ~/bin/
	fi
}

#X11
browser () { ## install chromium
	sudo apt-get install chromium-browser
}
player () { ## install vlc
	sudo apt install ubuntu-restricted-extras
	sudo apt-get install vlc
}
pdf () { ## install pdf viewer (zathura)
	sudo apt install zathura
}
gnome () { ## install gnome config tools
	sudo apt-get install gnome-tweak-tool
	sudo apt install gnome-shell-extensions
	sudo apt-get install chrome-gnome-shell
	sudo apt install dconf-tools
}
x11 () { ## install x11 tools [meta package]
	if [ "$OS" != "windows" ]; then 
		browser;
		player;
	fi
	gnomever = $(gnome-shell --version)
	if [ "$gnomever" = "GNOME"* ]; then
		gnome;
	fi
	pdf;
}

laptop () { ## install laptop tools
	sudo apt install tlp tlp-rdw
	sudo tlp start
}

#db
db () { ## install db (postgresql)
	sudo apt-get install postgresql postgresql-client 
	sudo systemctl disable postgresql
}

dbclient () { ## install db client psql (postgresql)
	sudo apt-get install postgresql-client 
}

# meta packages
min () { ## install minimal system [meta package]
	update; dev; plan9; dbclient; vim; clean;
}

full () { ## install full system
	dev; vim; neovim; emacs; vscode; plan9; db;
}

#selector
if [ "$#" -le 1 ]; then
	echo "No Arguments use minimal installation"
	min;
else
case $1 in 
	"help") echo "Help";
		echo "Installer:";
		sed -n  -e 's/\s() { ##/:\n\t/p' $ROOT/$0;;
	*) shift; $@;;
esac
fi
