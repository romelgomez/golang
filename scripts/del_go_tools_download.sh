GOTOOLS=$HOME/go/tools

if [ ! -z "$1" ]; then
    GOTOOLS=$1
fi

echo "Removing Download if it exists"

find $GOTOOLS -name "*.tar.gz" -type f -delete
