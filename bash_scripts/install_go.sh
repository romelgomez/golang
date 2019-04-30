#!/bin/bash

# Install Golang Tools
# ....................
# TODO:
# [] Download the last version from:  https://golang.org/dl/
# [] Make TEST

# Parameters:
# -b go_binary.tar.gz

function err() { 1>&2 echo "$0: error $@"; return 1; }

function unpack() {
  rm -rf $HOME/go/tools/go
  tar -C $HOME/go/tools -xzvf $BINARY
}

function env () {
  if [[ -z "$GOROOT" ]]; then
      export GOROOT=$HOME/go/tools/go
      export PATH=$PATH:$GOROOT/bin

      echo '' >> ~/.bashrc
      echo '# Golang' >> ~/.bashrc
      echo 'export GOROOT=$HOME/go/tools/go' >> ~/.bashrc
      echo 'export PATH=$PATH:$GOROOT/bin' >> ~/.bashrc    
      echo '' >> ~/.bashrc
  fi
}

function go_tool_version () {
  echo ""
  echo "The Go tool version installed is:"
  echo "------------------------------"  
  go version
  echo "------------------------------"  
  echo ""  
}

while getopts "b:" opt;
do
  case $opt in
    b) BINARY="$OPTARG" ;;
    :) err "Option -$OPTARG requires an argument.";;
    \?) err "Invalid option: -$OPTARG";;
  esac
done

if [ -z "$BINARY" ]; then
  echo "The option: -b go_binary.tar.gz is missing!"
else
  echo $BINARY
  unpack
  env
  go_tool_version
fi
