#!/bin/bash

apt update
apt install wget libusb-1.0-0 -y

## The following is based on nrf-docker: https://github.com/NordicPlayground/nrf-docker/blob/saga/Dockerfile
# Nordic command line tools
# Releases: https://www.nordicsemi.com/Products/Development-tools/nrf-command-line-tools/download
NORDIC_COMMAND_LINE_TOOLS_VERSION="10-23-2/nrf-command-line-tools-10.23.2"
NCLT_BASE="https://nsscprodmedia.blob.core.windows.net/prod/software-and-other-downloads/desktop-software/nrf-command-line-tools/sw/versions-10-x-x"
ARCH_STR="linux-amd64"
mkdir tmp && cd tmp
wget "${NCLT_BASE}/${NORDIC_COMMAND_LINE_TOOLS_VERSION}_${ARCH_STR}.tar.gz"
tar --no-same-owner -xzf *.tar.gz
# Install included JLink
mkdir -p /opt/SEGGER
tar xzf JLink_*.tgz -C /opt/SEGGER
mv /opt/SEGGER/JLink* /opt/SEGGER/JLink
# Install nrf-command-line-tools
cp -r ./nrf-command-line-tools /opt
ln -s /opt/nrf-command-line-tools/bin/nrfjprog /usr/local/bin/nrfjprog
ln -s /opt/nrf-command-line-tools/bin/mergehex /usr/local/bin/mergehex
cd .. && rm -rf tmp

## This is the Zephyr/Golioth specific setup
west init -l app
west update
west zephyr-export
pip install -r deps/zephyr/scripts/requirements.txt
echo "alias ll='ls -lah'" >> $HOME/.bashrc
west completion bash > $HOME/west-completion.bash
echo 'source $HOME/west-completion.bash' >> $HOME/.bashrc
history -c
