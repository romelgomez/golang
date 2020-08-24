#!/bin/bash

function err() { 1>&2 echo "$0: error $@"; return 1; }

while getopts "b:" opt;
do
  case $opt in
    b) BINARY="$OPTARG" ;;
    :) err "Option -$OPTARG requires an argument.";;
    \?) err "Invalid option: -$OPTARG";;
  esac
done

if [ -z "$BINARY" ]; then

  echo "NOTE: The optional option: -b go_binary.tar.gz is missing. Trying to download the latest Go binary."

  . scripts/del_go_tools_folder.sh

  . scripts/go_tools.sh

  . scripts/enviroment.sh

  . scripts/del_go_tools_download.sh

  go version

else

  echo $BINARY

  . scripts/del_go_tools_folder.sh

  tar -C $GOTOOLS -xzvf $BINARY

  . scripts/enviroment.sh
  
  go version

fi
