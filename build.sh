#!/bin/bash

echo "installing build essentials"
sudo su <<EOF
apt-get update && \
apt-get -y install \
\
build-essential \
git \
libsdl1.2-dev \

EOF

git clone http://github.com/kaplan2539/ioquake3-chip
pushd ioquake3-chip
make
popd

echo "installing openarena assets..."
sudo apt-get -y install openarena

CONFIG_DIR=~/.q3a/baseq3

mkdir -p "${CONFIG_DIR}"

pushd "${CONFIG_DIR}"
for a in /usr/lib/openarena/baseoa/*.so /usr/lib/openarena/baseoa/pak0; do ln -s $a; done
for a in /usr/share/games/openarena/baseoa/*.pk3; do ln -s $a; done
popd

echo "adding special rule to awesome configuration"
patch ~/.config/awesome/rc.lua <awesome.patch

