#!/usr/bin/env bash


git clone https://github.com/vim/vim.git

sudo yum install python-devel
sudo yum install python3-devel
sudo yum install ncurses ncrses-devel

cd vim/src
sudo make clean

./configure --with-features=huge \
  --enable-multibyte \
  --enable-pythoninterp=dynamic \
  --with-python-config-dir=/usr/lib/python2.7/config \
  --enable-python3interp=dynamic \
  --with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu/ \
  --enable-cscope \
  --enable-gui=auto \
  --enable-gtk2-check \
  --enable-fontset \
  --enable-largefile \
  --disable-netbeans \
  --with-compiledby="lunzhoufei@gmail.com" \
  --enable-fail-if-missing \
  --prefix=/usr/local/vim

sudo make install


# TO SEE if support python => vim --version |grep python
