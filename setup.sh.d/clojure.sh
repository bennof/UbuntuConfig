#!bin/sh

# install Clojure with JDK

# info
cat <<EOF
Clojure
install Clojure with JDK and lein
EOF

# install
sudo apt-get install openjdk-11-jdk
if [ ! -d ~/.bin ] ; then
	mkdir -p ~/.bin
	echo "PATH=$HOME/.bin:\$Path export PATH" >> ~/.profile
fi
wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O ~/.bin/lein
chmod u+x ~/.bin/lein
