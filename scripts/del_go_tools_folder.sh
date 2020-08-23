GOTOOLS=$HOME/go/tools

if [ ! -z "$1" ]; then
    GOTOOLS=$1
fi

echo "Removing old go tools if it exists"

rm -rf $GOTOOLS/go
