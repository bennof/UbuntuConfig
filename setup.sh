#!/bin/sh

echo "Ubuntu Config Script"
echo "written by Benjamin Falkner"

#check for os
VERSION=$(uname -v)
case "$VERSION" in 
	*"Microsoft"*)
		OS="Windows";;
	*"Ubuntu"*)
		OS="Ubuntu";;
	*)
		OS="Linux";;
esac


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
	$ROOT/setup.sh.d/vim.sh
}

neovim () { ## install neovim
	$ROOT/setup.sh.d/neovim.sh
}

emacs () { ## install emacs with spacemacs
	git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
	sudo apt-get install emacs
}

vscode () { ## install Microsoft Visual Studio Code
	$RROT/setup.sh.d/vscode.sh
}

#programming 
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
	$ROOT/setup.sh.d/clojure.sh
}
erlang () { ## install erlang and elixir
	$ROOT/setup.sh.d/erlang.sh
}

dev () { ## install development tools [meta package]
	git; clike; js; python; clojure; erlang
}
#plan9
plan9 () { ## install plan 9 tools
	$ROOT/setup.sh.d/plan9.sh
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
if [ "$#" -eq 0 ]; then
	echo "No Arguments use minimal installation"
	min;
else
case $1 in 
	"help") echo "Help";
		echo "Installer:";
		sed -n  -e 's/\s() { ##/:\n\t/p' $ROOT/$0;;
	*) 	echo ">> $@"
		$@;;
esac
fi
