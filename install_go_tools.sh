#!/bin/bash

# Parameters:
# -b go_binary.tar.gz

function err() { 1>&2 echo "$0: error $@"; return 1; }

function downloadLatestGo () {
  GOURLREGEX='https://dl.google.com/go/go[0-9\.]+\.linux-amd64.tar.gz'
  echo "Finding latest version of Go for AMD64..."
  url="$(wget -qO- https://golang.org/dl/ | grep -oP 'https:\/\/dl\.google\.com\/go\/go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1 )"
  latest="$(echo $url | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2 )"
  echo "Downloading latest Go for AMD64: ${latest}"
  wget --quiet --continue --show-progress "${url}" -P $HOME/go/tools
  unset url
  unset GOURLREGEX
}

function removeGoTools () {
  echo "Removing old go tools if it exists"
  rm -rf $HOME/go/tools/go
}

function removeDownload () {
  echo "Removing Download"
  find $HOME/go/tools -name "*.tar.gz" -type f -delete
}

function env () {
  echo "Setting the environment variables"
  if [[ -z "$GOROOT" ]] || [[ -z "$GOPATH" ]]; then
  
    # GOROOT
    export GOROOT=$HOME/go/tools/go
    export PATH=$PATH:$GOROOT/bin

    # GOPATH
    LIBRARIES=$HOME/go/libraries
    WORKSPACE=$HOME/go/workspace

    export GOPATH=$LIBRARIES:$WORKSPACE

    export PATH=$PATH:$LIBRARIES/bin:$WORKSPACE/bin
    echo '

    #[Golang].................................

    # GOROOT
    export GOROOT=$HOME/go/tools/go
    export PATH=$PATH:$GOROOT/bin

    # GOPATH
    LIBRARIES=$HOME/go/libraries
    WORKSPACE=$HOME/go/workspace

    export GOPATH=$LIBRARIES:$WORKSPACE

    export PATH=$PATH:$LIBRARIES/bin:$WORKSPACE/bin

    #.................................[/Golang]
        
    ' >> ~/.profile && source ~/.profile

    echo 'source ~/.profile' >> ~/.zshrc

    echo 'source ~/.profile' >> ~/.bashrc

  fi
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

  echo "
   NOTE: The optional option: -b go_binary.tar.gz is missing.

   Trying to download the latest Go binary.
  "

  downloadLatestGo

  LATEST="$(find $HOME/go/tools -name "go*" -type f | head -n 1)"

  echo "LATEST: ${LATEST}"

  removeGoTools

  tar -xzvf $LATEST --directory $HOME/go/tools

  env

  removeDownload

  go version

else

  echo $BINARY

  removeGoTools

  tar -C $HOME/go/tools -xzvf $BINARY

  env
  
  go version

fi
