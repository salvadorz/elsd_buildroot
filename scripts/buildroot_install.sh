#!/bin/sh
# Script to install all buildroot dependencies
# Author: Salvador Zendejas

### Mandatory packages ###
# https://buildroot.org/downloads/manual/manual.html#requirement-mandatory
# recomended libncurses5-dev (ncurses-5) also

sudo apt-get install \
sed \
make  \
binutils \
build-essential \
diffutils \
bash \
patch \
gzip \
bzip2 \
perl  \
tar \
cpio \
unzip \
rsync \
file \
bc \
findutils 