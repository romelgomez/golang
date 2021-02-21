#!/bin/bash

function del_go_tools_download() {

    echo "Removing Download if it exists"

    find $PWD -name "*.tar.gz" -type f -delete

}

function del_go_tools_folder() {

    echo "Removing old go tools if it exists"

    rm -rf $PWD/go

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

    wget --no-check-certificate --continue --show-progress "$DL_HOME$DL_PATH_URL" -P $PWD

    unset DL_PATH_URL

    GOTOOL_FILE="$(find $PWD -name "go*.tar.gz" -type f | head -n 1)"

    echo "LATEST: ${GOTOOL_FILE}"

    tar -xzvf $GOTOOL_FILE --directory $PWD

}

function enviroment() {

    echo "..:: Setting the environment variables for golang"

    if [[ -z "$GOROOT" ]] || [[ -z "$GOPATH" ]]; then

        SETTING_GOROOT="export GOROOT=$PWD/go"
        SETTING_PATH='export PATH=$PATH:$GOROOT/bin'

        echo "save in .zshrc file" 

        echo "" >>~/.zshrc
        echo "# [start] Golang settings, remove after change the installation folder." >>~/.zshrc
        echo $SETTING_GOROOT >>~/.zshrc
        echo $SETTING_PATH >>~/.zshrc
        echo "# [end]" >>~/.zshrc
        echo "" >>~/.zshrc

        echo "save in bashrc file" 

        echo "" >>~/.bashrc
        echo "# [start] Golang settings, remove after change the installation folder." >>~/.bashrc
        echo $SETTING_GOROOT >>~/.bashrc
        echo $SETTING_PATH >>~/.bashrc
        echo "# [end]" >>~/.bashrc
        echo "" >>~/.bashrc

        echo $SHELL

        if [ "$SHELL" = "/usr/bin/zsh" ]; then
            echo "source ~/.zshrc" 
            source ~/.zshrc
        else
            echo "source ~/.bashrc" 
            source ~/.bashrc
        fi

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
