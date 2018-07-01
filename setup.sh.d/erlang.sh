#!/bin/sh

# install erlang

# info
cat <<EOF
EOF

# install
if [ ! -f /etc/apt/sources.list.d/erlang-solutions.list ]; then
	wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
	sudo dpkg -i erlang-solutions_1.0_all.deb
	sudo apt-get update
	rm erlang-solutions_1.0_all.deb
fi
sudo apt-get install esl-erlang elixir
