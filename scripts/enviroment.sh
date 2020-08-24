#!/bin/bash

. scripts/clean_path.sh

if [[ -z "$GOROOT" ]] || [[ -z "$GOPATH" ]]; then

echo "..:: Setting the environment variables \n"

echo "

export GOROOT=$PWD/.tools/go
export GOPATH=$PWD/go_modules:$PWD/workspace
export PATH=$PATH:$GOROOT/bin:$PWD/go_modules/bin:$PWD/workspace/bin

" >> ~/.profile && source ~/.profile

echo 'source ~/.profile' >> ~/.zshrc
echo 'source ~/.profile' >> ~/.bashrc

fi