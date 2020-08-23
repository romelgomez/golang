#!/bin/bash

echo "

    ..:: Download Latest Go

"


GOTOOLS=$HOME/go/tools

if [ ! -z "$1" ]; then
    GOTOOLS=$1
fi

mkdir -p $GOTOOLS

DL_HOME=https://golang.org

echo "Finding latest version of Go for AMD64..."

# 
# ..:: Get the file path e.g:
# 
# /dl/go1.15.linux-amd64.tar.gz
# 
DL_PATH_URL="$(wget --no-check-certificate -qO- https://golang.org/dl/ | grep -oP '\/dl\/go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)" 

latest="$(echo $DL_PATH_URL | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2 )"

echo "Downloading latest Go for AMD64: ${latest}"

wget --no-check-certificate --continue --show-progress "$DL_HOME$DL_PATH_URL" -P $GOTOOLS

unset DL_PATH_URL

LATEST="$(find $GOTOOLS -name "go*" -type f | head -n 1)"

echo "LATEST: ${LATEST}"

tar -xzvf $LATEST --directory $GOTOOLS
