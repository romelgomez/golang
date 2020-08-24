#!/bin/bash

echo "

    ..:: Download Latest Go

"

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

wget --no-check-certificate --continue --show-progress "$DL_HOME$DL_PATH_URL" -P $PWD/.tools

unset DL_PATH_URL

GOTOOL_FILE="$(find $PWD/.tools -name "go*.tar.gz" -type f | head -n 1)"

echo "LATEST: ${GOTOOL_FILE}"

tar -xzvf $GOTOOL_FILE --directory $PWD/.tools
