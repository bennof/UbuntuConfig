#!/bin/sh

# install plan9 

# info 
cat <<EOF
Plan9Port 
install plan 9 tools like acme, rc and 9p
EOF

# install

sudo apt-get install xorg-dev fonts-lato fonts-open-sans
if [ ! -d ~/plan9port ]; then 
	git clone https://github.com/9fans/plan9port ~/plan9port
	cd ~/plan9port
	./INSTALL 
	cd ..
	cat <<EOF >> .profile
PLAN9=$HOME/plan9port export PLAN9
PATH=\$PATH:\$PLAN9/bin export PATH
if [ ! pgrep fontsrv ]; then 
	fontsrv &
fi

if [ ! pgrep plumber ]; then 
	plumber &
fi
alias acme="acme -a -f /mnt/font/'Lato Regular'/13a/font"
EOF
	mkdir -p ~/.bin
	cp $ROOT/bin/* ~/.bin/
fi


