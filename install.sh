#!/bin/bash
mkdir emacs
cd emacs
git init
git remote add origin https://github.com/emacs-mirror/emacs.git
git fetch --depth 1 origin emacs-26
git reset --hard FETCH_HEAD
git am ../*.patch
sudo apt install autoconf make gcc texinfo libgtk-3-dev libxpm-dev libjpeg-dev libgif-dev libtiff5-dev libgnutls-dev libncurses5-dev mailutils
./configure
./autogen.sh
./configure --prefix=/opt/emacs26 --docdir=/opt/emacs26/doc --mandir=/opt/emacs26/man --infodir=/opt/emacs26/info --with-mailutils
time make -j$(nproc)
echo "GNU/Emacs 26" > ./description-pak
sudo checkinstall --pkgname emacs-git --pkgversion 26 --maintainer $(whoami) --nodoc
