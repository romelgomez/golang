#!/bin/bash

ARCH=$(uname -m)
OS=$(uname -o)

function processor_architecture() {

    case $ARCH in
        i?86)
        ARCH_VERSION="386";;

        x86_64)
        ARCH_VERSION="amd64";;

        # Architectures below haven't been tested; of you have one, feel free to open a PR with the corrections
        armv*)
        ARCH_VERSION="arm";;

        arm64|aarch64)
        ARCH_VERSION="arm64";;

        s390x)
        ARCH_VERSION="s390x";;

        ppc64*)
        ARCH_VERSION="ppc64le";;
    esac
}


function operating_system() {

    case $OS in
        Linux|GNU/Linux|inux)
        OS="linux"
        GO_INSTALL_PREFIX="/usr/local/";;

        Darwin)
        OS="mac"
        GO_INSTALL_PREFIX="/usr/local/";;

        BSD|FreeBSD)
        OS="freebsd"
        GO_INSTALL_PREFIX="/usr/local/";;

        S390)
        OS="s390x"
        ;;
        # TODO: check GO_INSTALL_PREFIX for this platform
        # TODO: finish adding support for Mac
        # TODO: add Windows support
        # More info here: https://go.dev/doc/manage-install
        # TODO: add support for more OS
    esac
}


function package_format(){

    case $OS in

        linux)
        PACKAGE_FORMAT="tar\.gz";;

        windows)
        PACKAGE_FORMAT="msi";;

        *)
        PACKAGE_FORMAT="tar\.gz";;

    esac
}

function del_go_tools_download() {

	echo "Removing previous download if it exists..."

	find $GO_INSTALL_PREFIX -name "*.$PACKAGE_FORMAT" -type f -delete

}

function del_go_tools_folder() {

	echo "Removing old go tools if it exists"

	rm -rf $GO_INSTALL_PREFIX/go

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

    ..:: Downloading Latest Go version...

    "

	DL_HOME=https://go.dev

	echo "Finding latest version of Go for $ARCH..."

	#
	# ..:: Get the file path e.g:
	#
	# /dl/go1.15.linux-386.tar.gz
	#
	DL_PATH_URL="$(wget --no-check-certificate -qO- https://go.dev/dl/ | grep -oP '\/dl\/go([0-9\.]+)\. ${OS}\-${ARCH_VERSION}\.${PACKAGE_FORMAT}' | head -n 1)"

	latest="$(echo $DL_PATH_URL | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2)"

	echo "Downloading latest Go for $ARCH: ${latest}"

	wget --no-check-certificate --continue --show-progress "$DL_HOME$DL_PATH_URL" -P $GO_INSTALL_PREFIX

	unset DL_PATH_URL

	GOTOOL_FILE="$(find $GO_INSTALL_PREFIX -name "go*.$PACKAGE_FORMAT" -type f | head -n 1)"

	echo "LATEST: ${GOTOOL_FILE}"

	tar -xzvf $GOTOOL_FILE --directory $GO_INSTALL_PREFIX

}

function enviroment() {

	echo "..:: Setting the environment variables for golang"

	if [[ -z "$GOROOT" ]] || [[ -z "$GOPATH" ]]; then

		SETTING_GOROOT="export GOROOT=$GO_INSTALL_PREFIX/go"
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

  processor_architecture

  operating_system

  package_format

	del_go_tools_folder

	go_tools

	enviroment

	del_go_tools_download

	go version

else

	echo $BINARY

  processor_architecture

  operating_system

  package_format

	del_go_tools_folder

	tar -C $GOTOOLS -xzvf $BINARY

	enviroment

	go version

fi
