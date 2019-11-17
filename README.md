# Install Go Tools in UBUNTU

To instal the go tools with this script, you has two options:

1.  Let the script install the lasted version of go tools.

    **a)** Open an terminal, stay in `$HOME`

    **b)** `git clone https://github.com/romelgomez/go.git`

    **c)** `. ./go/install_go_tools.sh`

2.  Pass the desirable version that you need to install with the flag `-b`

    **a)** Download a binary release suitable for your system in [https://golang.org/dl/](https://golang.org/dl/)

    **b)** Open an terminal, stay in \$HOME

    **c)** `git clone https://github.com/romelgomez/go.git`

    **d)** - `. ./go/install_go_tools.sh -b go_binary.tar.gz`

    Example:

    `. ./go/install_go_tools.sh -b $HOME/Downloads/go1.12.4.linux-amd64.tar.gz`

## NOTES

- To update or change the version, run again.

`Better skills = A better life`
