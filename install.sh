#!/bin/bash

GO_MODULES=$PWD/go_modules

function del_go_tools_download() {

    echo "Removing Download if it exists"

    find $GO_MODULES -name "*.tar.gz" -type f -delete

}

function del_go_tools_folder() {

    echo "Removing old go tools if it exists"

    rm -rf $GO_MODULES/go

}

#
# Remove duplicate $PATH entries with awk command
# https://unix.stackexchange.com/a/40973
#

function clean_path() {

    if [ -n "$PATH" ]; then
        old_PATH=$PATH:
        PATH=
        while [ -n "$old_PATH" ]; do
            x=${old_PATH%%:*} # the first remaining entry
            case $PATH: in
            *:"$x":*) ;;        # already there
            *) PATH=$PATH:$x ;; # not there yet
            esac
            old_PATH=${old_PATH#*:}
        done
        PATH=${PATH#:}
        unset old_PATH x
    fi

}

function go_tools() {
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

    latest="$(echo $DL_PATH_URL | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2)"

    echo "Downloading latest Go for AMD64: ${latest}"

    wget --no-check-certificate --continue --show-progress "$DL_HOME$DL_PATH_URL" -P $GO_MODULES

    unset DL_PATH_URL

    GOTOOL_FILE="$(find $GO_MODULES -name "go*.tar.gz" -type f | head -n 1)"

    echo "LATEST: ${GOTOOL_FILE}"

    tar -xzvf $GOTOOL_FILE --directory $GO_MODULES

}

function enviroment() {

    echo "
        ..:: Setting the environment variables for golang
    "

    clean_path

    if [[ -z "$GOROOT" ]] || [[ -z "$GOPATH" ]]; then
        GOROOT=$GO_MODULES/go

        GOPATH=$GO_MODULES:$PWD/src

        PATH=$PATH:$GOROOT/bin:$GO_MODULES/bin:$PWD/src/bin

        GOLANG_SETTINGS="
            # [start] Golang settings, remove after change the installation folder.
            export GOROOT=$GOROOT
            export PATH=$PATH
            export GOPATH=$GOPATH
            # [end]
        "

        echo $GOLANG_SETTINGS >>~/.zshrc

        echo $GOLANG_SETTINGS >>~/.bashrc
    fi

}

function err() {
    echo 1>&2 "$0: error $@"
    return 1
}

while getopts "b:" opt; do
    case $opt in
    b) BINARY="$OPTARG" ;;
    :) err "Option -$OPTARG requires an argument." ;;
    \?) err "Invalid option: -$OPTARG" ;;
    esac
done

if [ -z "$BINARY" ]; then

    echo "NOTE: The optional option: -b go_binary.tar.gz is missing. Trying to download the latest Go binary."

    del_go_tools_folder

    go_tools

    enviroment

    del_go_tools_download

    go version

else

    echo $BINARY

    del_go_tools_folder

    tar -C $GOTOOLS -xzvf $BINARY

    enviroment

    go version

fi
