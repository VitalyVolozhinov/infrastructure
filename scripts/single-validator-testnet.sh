#! /bin/bash
set -e
##### Spins up and starts a single validator Osmosis testnet

#### Parameters
export CHAIN_ID="osmosis-clean-testnet-X"
export VERSION="v6.0.0"

#### Initial node setup
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install curl build-essential jq git wget liblz4-tool aria2 make -y

curl https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash

export GOROOT=/root/.go
export PATH=$GOROOT/bin:$PATH
export GOPATH=/root/go
export PATH=$GOPATH/bin:$PATH

cd /root/

rm /root/osmosis/ -rf
git clone https://github.com/osmosis-labs/osmosis
cd osmosis
git checkout $VERSION
make install

rm /root/.osmosisd/ -rf
source ~/.bashrc
osmosisd config chain-id $CHAIN_ID
osmosisd init "testnet-validator" --chain-id=$CHAIN_ID

osmosisd version
osmosisd config

echo "You can now login to the server and execute: osmosisd start or setup the genesis state"
